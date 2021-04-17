// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Policy.sol";
import "./Token.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract Claim {
    
    SRXToken public token;
    address payable holder;
    address public operator;
    uint public netClaimAmount;
    int public verdict;
    bytes32 coverCurrency1;
    bytes32 coverCurrency2;

    modifier onlyOperator() {
        if (operator != address(0))
            require(msg.sender == operator, "Not operator.");
        _;
    }
    
    constructor(
        SRXToken _token,
        address payable _holder,
        address _operator,
        uint _netClaimAmount,
        int _verdict
    ) {
        token = _token;
        holder = _holder;
        operator = _operator;
        netClaimAmount = _netClaimAmount;
        verdict = _verdict;
        coverCurrency1 = 'BNB';
        coverCurrency2 = 'SRX';
        
    }

    
    function Payout(
        uint totalEligibleCover
        ) 
        external 
        onlyOperator 
        returns(bool success){
        require(netClaimAmount > 0, 'Net Claim amount must be more than Zero');
        require(netClaimAmount <= totalEligibleCover, 'Net claim should be equal or less than eligible cover');
        
        //Payout
        if (coverCurrency1 == "BNB" && address(this).balance <= totalEligibleCover){
            holder.transfer(netClaimAmount);
            success = true;
        } else if (coverCurrency2 == "SRX" && token.balanceOf(address(this)) <= totalEligibleCover) {
            holder.transfer(netClaimAmount);
            success = true;
        }
    }
    
}
