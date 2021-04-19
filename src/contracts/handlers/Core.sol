// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "../Token.sol";

contract Core {
     // Token
    SRXToken public token;
    
    // Tokenomics
    uint public opsRateBIPS;            // fee rate for operations
    uint public reserveBalance;         // must be tracked for staking mechanism
    address payable public operations;  // operations account (contract)
    
    constructor(uint useOpsRateBIPS) {
        token = new SRXToken(address(this));
        opsRateBIPS = useOpsRateBIPS;
        operations = payable(msg.sender);
    }

    /**
     * @dev Calculates the amount of tokens to mint for the tendered amount of reserve tokens.
     */
    function calculateMintAmount(uint tenderAmount) public view returns (uint) {
        require(tenderAmount >= 1000, "Tendered amount must be at least 1000 wei");
        uint fee = tenderAmount * opsRateBIPS / 10000;
        uint mintAmount = tenderAmount - fee;
        return mintAmount;
    }
    
    /**
     * @dev Calculates the minimum mint amount.
     * formula: 1000 wei - fee = minimum mint amount;
     */
    function calculateMinimumMintAmount() public view returns (uint) {
        uint fee = 1000 * opsRateBIPS / 10000;
        uint mintAmount = 1000 - fee;
        return mintAmount;
    }
    
    /**
     * @dev Calculates the amount of reserve tokens required to mint the target amount of tokens.
     */
    function calculateTenderAmount(uint targetAmount) public view returns (uint) {
        require(targetAmount >= calculateMinimumMintAmount(), "Target amount must be at least minimum mint amount.");
        uint tenderAmount = targetAmount * 10000 / (10000 - opsRateBIPS);
        return tenderAmount;
    }

    /**
     * @dev Internal function that mints an amount of tokens for the tendered amount of reserve tokens.
     * formulas:
     * opsAmount = tenderAmount * opsRateBIPS / 10000; [fee]
     * mintAmount = tenderAmount / tokenPrice; [mint]
     * tokenPrice = tokenValue / (1 - opsRateBIPS / 10000); [buy]
     * tokenValue = reserveBalance / tokenSupply; [sell]
     */
    function _buy(uint tenderAmount) internal {
        require(tenderAmount >= 1000, "Tendered amount must be at least 1000 wei.");
        uint opsAmount = tenderAmount * opsRateBIPS / 10000;
        uint mintAmount = tenderAmount - opsAmount;
        operations.transfer(opsAmount);
        token.mint(msg.sender, mintAmount);
        reserveBalance += mintAmount;
    }

    /**
     * @dev Buys an amount of SRX with the given reserve tokens (e.g. ETH, BNB, etc).
     */
    function buy() payable public returns (bool) {
        _buy(msg.value);
        return true;
    }
    
    /**
     * @dev Buys the specified amount of SRX with the given reserve tokens, provided they are sufficient.
     */
    function buy(uint amount) payable public returns (bool) {
        uint tenderAmount = calculateTenderAmount(amount);
        require(msg.value >= tenderAmount, "Insufficient value provided to buy target amount.");
        _buy(tenderAmount);
        if (msg.value > tenderAmount) {
            uint refund = msg.value - tenderAmount;
            payable(msg.sender).transfer(refund);
        }
        return true;
    }

    /**
     * @dev Calculates the amount of reserve tokens to refund for the given tender amount.
     * formulas:
     * tokenValue = reserveBalance / tokenSupply; [sell]
     */
    function calculateRefundAmount(uint tenderAmount) public view returns (uint) {
        require(tenderAmount <= totalSupply(), "Amount exceeds total supply.");
        return tenderAmount * (reserveBalance / totalSupply());
    }

    /**
     * @dev Internal function that refunds an amount of reserve token for the given tokens.
     * The given tokens are burned.
     */
    function _sell(uint tenderAmount) internal {
        require(tenderAmount > 0, "Tendered amount must be greater than zero");
        require(token.balanceOf(msg.sender) >= tenderAmount, "Insufficient tokens to sell");
        uint refundAmount = calculateRefundAmount(tenderAmount);
        
        token.burn(msg.sender, tenderAmount);
        payable(msg.sender).transfer(refundAmount);
        reserveBalance -= refundAmount;
    }

    /**
     * @dev Sells an amount of SRX for reserve tokens from the reserve.
     */
    function sell(uint tenderAmount) public {
        _sell(tenderAmount);
    }
    
    /**
     * @dev Returns the available balance of the reserve (excludes staked value).
     */
    function availableReserveBalance() public view returns (uint) {
        return address(this).balance;
    }
    
    /**
     * @dev Returns the token total supply.
     */
    function totalSupply() public view returns (uint) {
        return token.totalSupply();
    }
}
