// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "../Token.sol";
import "../Policy.sol";

import "./Core.sol";
import "./Quotes.sol";

abstract contract Policies is Core, Quotes {
    uint public riskRateBIPS;   // default annual risk rate
    
    mapping(address => address[]) internal policies;    // account => policies
    
    constructor() {
        riskRateBIPS = 1000;
    }
    
    /**
     * @dev Returns a CoverQuote for the given values.
     * Currently utilizes a predetermined risk rate of 1000 BIPS (10%) per annum, this can later be dynamically
     * calculated from caller history and other external sources.
     */
    function requestForCover(uint _target, uint _term, uint _deposit) public view returns(CoverQuote memory) {
        // riskRate may later be obtained via risk evaluation function / service.
        uint _riskRateBIPS = riskRateBIPS;
        return _coverQuote(_target, _term, _deposit, _riskRateBIPS);
    }
    
    /**
     * @dev Creates a new policy with the given values and takes payment of the first installment.
     * msg.value must be sufficient to purchase the correct amount of tokens.
     */
    function createPolicy(uint _target, uint _term, uint _deposit) public payable returns(bool) {
        // riskRate may later be obtained via risk evaluation function / service.
        uint _riskRateBIPS = riskRateBIPS;
        
        // obtain quote and ensure tokens are available for first installment
        CoverQuote memory q = _coverQuote(_target, _term, _deposit, riskRateBIPS);
        if(token.balanceOf(msg.sender) < q.firstInstallment) {
            require(buy(q.firstInstallment), "Token purchase failed.");
        }
        
        // create policy
        Policy p = new Policy(
            token,
            msg.sender,     // policy holder
            _target,
            _term,
            _deposit,
            _riskRateBIPS
        );
        policies[msg.sender].push(address(p));
        token.approveTransferer(address(p));
        
        // pay initial installment
        // no need to check allowance as policy is newly created
        //token.approve(msg.sender, address(p), p.calculatePayment());
        //require(p.payPolicy(), "Failed to create policy, unable to make initial payment.");
        
        return true;
    }
    
    function accountPolicies(address account) public view returns (address[] memory) {
        return policies[account];
    }
    
    /*function payPolicy(Policy _policy) public payable returns (bool) {
        require(msg.sender == _policy.holder(), "Not policy holder.");
        uint paymentDue = _policy.calculatePayment();
        require(token.balanceOf(_policy.holder()) >= paymentDue, "Insufficient SRX tokens to pay policy.");
        //token.transfer(_policy.holder() , address(_policy), paymentDue);
        return true;
    }*/
}