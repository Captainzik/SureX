// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "./external/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SRXToken is ERC20 {
    address public operator;
    mapping(address => bool) approvedTransferers;

    modifier onlyOperator() {
        if(operator != address(0))
            require(msg.sender == operator, "Not operator.");
        _;
    }
    
    modifier onlyApproved() {
        if(address(msg.sender) != operator)
            require(approvedTransferers[msg.sender]);
        _;
    }

    constructor(address useOperator) ERC20("SureX Token", "SRX") {
        operator = useOperator;
    }

    function updateOperator(address newOperator) public onlyOperator returns (bool) {
        operator = newOperator;
        return true;
    }
    
    function approveTransferer(address transferer) public onlyOperator returns (bool) {
        approvedTransferers[transferer] = true;
        return true;
    }
    
    function denyTransferer(address transferer) public onlyOperator returns (bool) {
        approvedTransferers[transferer] = false;
        return true;
    }
    
    function approvedTransfer(address sender, address recipient, uint amount) public onlyApproved returns (bool) {
        _transfer(sender, recipient, amount);
        return true;
    }

    function mint(address account, uint amount) public onlyOperator {
        _mint(account, amount);
    }

    function burn(address account, uint amount) public onlyOperator {
        _burn(account, amount);
    }
}
