// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "./Token.sol";

contract Policy {
    // initial state data
    SRXToken public token;      // SRX token contract
    address public holder;      // policy holder account address
    uint public target;         // savings target
    uint public term;           // policy term in months (30 day periods)
    uint public deposit;        // initial deposit
    uint public riskRateBIPS;   // annual risk rate in BIPS
    uint public inceptionDate;  // Unix epoch timestamp
    uint public maturityDate;   // Unix epoch timestamp
    
    // current state
    uint public period;         // current period
    uint public savings;        // value accrued to date
    uint public premiumsPaid;   // accumulated premiums paid (for eventual no-claim rewards)
    uint[] public payments;     // array of due dates (Unix epoch timestamp) keyed by period
    
    constructor(
        SRXToken _token,
        address _holder,
        uint _target,
        uint _term,
        uint _deposit,
        uint _riskRateBIPS
    ) {
        token = _token;
        holder = _holder;
        target = _target;
        term = _term;
        deposit = _deposit;
        riskRateBIPS = _riskRateBIPS;
        
        inceptionDate = block.timestamp;
        maturityDate = inceptionDate + term * 30 days;
        
        period = 0;
        savings = _deposit;
        premiumsPaid = 0;
        
        payments = new uint[](term+1);
        for(uint i = 0; i <= _term; i++) {
            payments[i] = inceptionDate + i * 30 days;
        }
    }
    
    function calculateCoverPremium() public view returns (uint) {
        return (target - (savings + calculateSavingsAnnuity())) * riskRateBIPS / 10000 / 12;
    }
    
    function calculateSavingsAnnuity() public view returns (uint) {
        if(period == 0) {
            return 0;
        }
        return (target - savings) / (term - period + 1);
    }
    
    /**
     * @dev Returns the value of the payment due.
     * For the inception period only cover is paid.
     * For the final period only the annuity is paid as the cover amount is zero.
     */
    function calculatePayment() public view returns (uint) {
        if(period == 0) {
            return calculateCoverPremium() + deposit;
        }
        return calculateSavingsAnnuity() + calculateCoverPremium();
    }
    
    function paymentSchedule() public view returns (uint[] memory) {
        return payments;
    }
    
    /**
     * @dev Returns true if, and only if, a payment is currently due.
     * It allows for payments to be made up to 48 hours in advance.
     */
    function paymentIsDue() public view returns (bool) {
        uint nextDueDate = payments[period];
        if(nextDueDate - 2 days > block.timestamp) {
            return false;
        }
        return true;
    }
    
    /**
     * @dev Returns true if, and only if, a payment is overdue.
     * It allows for payments to be made up to 48 hours after being due,
     * whereafter it is considered overdue.
     */
    function paymentOverdue() public view returns (bool) {
        uint nextDueDate = payments[period];
        if(nextDueDate + 2 days > block.timestamp) {
            return false;
        }
        return true;
    }
    
    /**
     * @dev Takes payment for the policy if, and only if, a payment is currently due.
     * Keeps separate track of current savings (for further calculations) and total premiums paid
     * (for future reward mechanisms related to no-claim policies).
     * Splits the payment into the annuity (currently held in the policy) and premium (sent to MCR).
     * 
     * TODO: implement a late payment penalty mechanism (eg 10% overhead on missed payment within 7 days)
     * threshold for number of missed payments, and time overdue that will result in policy cancellation.
     * Cancellation will retain a portion of the savings as fees and refund the policyholder the remainder.
     */
    function payPolicy() public returns (bool) {
        require(paymentIsDue(), "No payment is currently due.");
        
        uint _premium = calculateCoverPremium();
        uint _annuity = calculateSavingsAnnuity();
        uint paymentDue;
        
        if(period == 0) {
            paymentDue += deposit;
            savings += deposit;
        }
        paymentDue += _annuity + _premium;
        savings += _annuity;
        premiumsPaid += _premium;
        
        require(token.balanceOf(holder) >= paymentDue, "Insufficient tokens to pay policy.");
        require(token.approvedTransfer(holder, address(this), paymentDue), "Token transfer failed.");
        
        // TODO: move annuity to Savings Capital (yield farm) and premium amount to Risk Based Capital
        
        period++;
        return true;
    }
}