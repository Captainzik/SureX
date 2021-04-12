// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SRXToken is IERC20 {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;
    uint256 private _reserve;

    string private _name = "SureX";
    string private _symbol = "SRX";
    uint8 private decimals = 18;
    address public operator;

    modifier onlyOperator() {
        if (operator != address(0))
            require(msg.sender == operator);
        _; // this is where the function code that utilizes the modifier will be called
    }

    constructor(address _founder, uint _initialSupply) {
        _mint(_founder, _initialSupply);
    }

    /**
    * @dev Total number of tokens in existence.
    */
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    /**
    * @dev Balance of the given address.
    */
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    /**
    * @dev Spending allowance given by an owner to a spender.
    */
    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
    * @dev Approve the given address to spend the given amount.
    */
    function approve(address spender, uint256 amount) public override returns (bool) {
        require(spender != address(0));

        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    /**
    * @dev Increase the spending allowance of the given spender by the given amount.
    */
    function increaseAllowance(address spender, uint256 amount) public returns (bool) {
        require(spender != address(0));

        _allowances[msg.sender][spender] += amount;
        emit Approval(msg.sender, spender, _allowances[msg.sender][spender]);
        return true;
    }

    /**
    * @dev Decrease the spending allowance of the given spender by the given amount.
    */
    function decreaseAllowance(address spender, uint256 amount) public returns (bool) {
        require(spender != address(0));

        _allowances[msg.sender][spender] -= amount;
        emit Approval(msg.sender, spender, _allowances[msg.sender][spender]);
        return true;
    }

    /**
    * @dev Change the operator address.
    */
    function changeOperator(address _newOperator) public onlyOperator returns (bool) {
        operator = _newOperator;
        return true;
    }

    /**
    * @dev Burns the given amount of tokens from the message sender account.
    */
    function burn(uint256 amount) public returns (bool) {
        _burn(msg.sender, amount);
        return true;
    }

    /**
    * @dev Burns the given amount of tokens from the given address and decrements the allowance.
    */
    function burnFrom(address from, uint256 amount) public returns (bool) {
        _burnFrom(from, amount);
        return true;
    }

    /**
    * @dev Mints the given amount of tokens and assigns it to the given address.
    */
    function mint(address account, uint256 amount) public onlyOperator {
        _mint(account, amount);
    }

    /**
    * @dev Transfers the given amount of tokens to the given address.
    */
    function transfer(address to, uint256 amount) public override returns (bool) {
        require(amount <= _balances[msg.sender]);
        _transfer(to, amount);
        return true;
    }

    /**
    * @dev Transfers the given amount of tokens from the first given address to the second given address.
    */
    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        require(amount <= _balances[from]);
        require(amount <= _allowances[from][msg.sender]);
        _transferFrom(from, to, amount);
        return true;
    }

    /**
    * @dev Calculates the amount of continuous tokens to mint for the given tender amount.
    */
    function calculateMintAmount(uint256 tenderAmount) public view returns (uint256) {
        // TODO: implement formula
        return 0;
    }

    /**
    * @dev Calculates the amount of reserve tokens to refund for the given tender amount.
    */
    function calculateRefundAmount(uint256 tenderAmount) public view returns (uint256) {
        // TODO: implement formula
        return 0;
    }

    /**
    * @dev Transfers the given amount of tokens to the given address.
    */
    function _transfer(address to, uint256 amount) internal {
        _balances[msg.sender] -= amount;
        _balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
    }

    /**
    * @dev Transfers the given amount of tokens from the first given address to the second given address.
    */
    function _transferFrom(address from, address to, uint256 amount) internal {
        _balances[from] -= amount;
        _balances[to] += amount;
        _allowances[from][msg.sender] -= amount;
        emit Transfer(from, to, amount);
    }

    /**
    * @dev Internal function that mints the given amount of tokens and assigns it to the given address.
    */
    function _mint(address account, uint256 amount) internal {
        require(account != address(0));
        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    /**
    * @dev Internal function that burns the given amount of tokens from the given account.
    */
    function _burn(address account, uint256 amount) internal {
        require(amount <= _balances[account]);

        _totalSupply -= amount;
        _balances[account] -= amount;
        emit Transfer(account, address(0), amount);
    }

    /**
    * @dev Internal function that burns the given amount of tokens from the given account,
    * and deducts the amount from the sender's allowance.
    */
    function _burnFrom(address account, uint256 amount) internal {
        require(amount <= _allowances[account][msg.sender]);
        _allowances[account][msg.sender] -= amount;
        _burn(account, amount);
        emit Approval(account, msg.sender, _allowances[account][msg.sender]);
    }

    /**
    * @dev Internal function that calculates and mints an amount of continuous token for the tendered amount.
    */
    function _buy(uint256 tenderAmount) internal {
        require(tenderAmount > 0, "Tender amount must be greater than zero.");
        uint256 mintAmount = calculateMintAmount(tenderAmount);
        _mint(msg.sender, mintAmount);
        // TODO: update reserve balance according to reserve ratio
        // TODO: emit event
    }

    /**
    * @dev Internal function that calculates and returns a refund amount of reserve token for the tendered amount.
    * The tendered amount of continuous token is burned.
    */
    function _sell(uint256 tenderAmount) internal {
        require(tenderAmount > 0, "Tender amount must be greater than zero.");
        require(_balances[msg.sender] >= tenderAmount, "Insufficient tokens.");

        uint256 refundAmount = calculateRefundAmount(tenderAmount);
        _reserve -= refundAmount; // remove refund amount from reserve
        _burn(msg.sender, tenderAmount); // remove tender amount from sender account
        // TODO: emit event
    }
}
