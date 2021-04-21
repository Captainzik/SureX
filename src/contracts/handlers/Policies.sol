// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "../Token.sol";
import "../Policy.sol";

import "./Core.sol";
import "./Quotes.sol";

abstract contract Policies is Core, Quotes {
    uint public riskRateBIPS;       // default annual risk rate in BIPS
    uint public overdueRateBIPS;    // default overdue fee rate in BIPS
    
    mapping(address => address[]) internal policies;    // account => policies
    
    constructor(uint _defaultRiskRateBIPS, uint _overdueRateBIPS) {
        riskRateBIPS = _defaultRiskRateBIPS;
        overdueRateBIPS = _overdueRateBIPS;
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
     * @dev Internal function to create a policy with the given parameters.
     * Ensures the policy is added to the account lookup, and that the policy is approved for making token transfers.
     */
    function _createPolicy(uint _target, uint _term, uint _deposit, uint _riskRateBIPS, uint _overdueRateBIPS) internal returns (Policy) {
        Policy p = new Policy(
            token,
            address(this),
            msg.sender,
            _target,
            _term,
            _deposit,
            _riskRateBIPS,
            _overdueRateBIPS
        );
        // add policy to account holder lookup
        policies[msg.sender].push(address(p));
        // approve policy to receive token payments
        token.approveTransferer(address(p));
        
        return p;
    }
    
    /**
     * @dev Creates a new policy with the given values and takes payment of the first installment.
     * msg.value must be sufficient to purchase the correct amount of tokens.
     */
    function createPolicy(uint _target, uint _term, uint _deposit) public payable returns(bool) {
        // riskRate may later be obtained via risk evaluation function / service.
        uint _riskRate = riskRateBIPS;
        
        // obtain quote and ensure tokens are available for first installment
        CoverQuote memory q = _coverQuote(_target, _term, _deposit, riskRateBIPS);
        if(token.balanceOf(msg.sender) < q.firstInstallment) {
            require(buy(q.firstInstallment), "Token purchase failed.");
        }
        
        // create policy
        Policy p = _createPolicy(_target, _term, _deposit, _riskRate, overdueRateBIPS);
        
        // pay initial installment
        require(p.payPolicy(), "Failed to create policy, unable to make initial payment.");
        
        return true;
    }
    
    function accountPolicies(address account) public view returns (address[] memory) {
        return policies[account];
    }
}
