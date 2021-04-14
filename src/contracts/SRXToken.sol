// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SRX is ERC20 {
    address public operator;

    modifier onlyOperator() {
        if (operator != address(0))
            require(msg.sender == operator, "Not operator.");
        _;
    }

    constructor(address useOperator) ERC20("SureX Token", "SRX") {
        operator = useOperator;
    }

    function updateOperator(address newOperator) public onlyOperator returns (bool) {
        operator = newOperator;
        return true;
    }

    function mint(address account, uint amount) public onlyOperator {
        _mint(account, amount);
    }

    function burn(address account, uint amount) public onlyOperator {
        _burn(account, amount);
    }
}
