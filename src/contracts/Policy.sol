// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "./Token.sol";

contract Policy {
    enum PolicyStatus {ACTIVE, MATURED, TERMINATED, CANCELLED}
    
    SRXToken internal token;        // SRX token contract
    address internal operator;      // operator address
    
    // initial state data
    address public holder;          // policy holder account address
    uint public target;             // savings target
    uint public term;               // policy term in months (30 day periods)
    uint public deposit;            // initial deposit
    uint public riskRateBIPS;       // annual risk rate in BIPS
    uint public overdueRateBIPS;    // overdue fee rate in BIPS
    uint public inceptionDate;      // Unix epoch timestamp
    uint public maturityDate;       // Unix epoch timestamp
    
    // current state
    PolicyStatus public status;
    
    uint public period;         // current period
    uint public savings;        // value accrued to date
    uint public premiumsPaid;   // accumulated premiums paid (for eventual no-claim rewards)
    uint[] public payments;     // array of due dates (Unix epoch timestamp) keyed by period
    
    modifier onlyOperator() {
        if(operator != address(0))
            require(msg.sender == operator, "Not operator.");
        _;
    }
    
    modifier onlyPolicyHolder() {
        if(address(msg.sender) != operator)
            require(address(msg.sender) == holder, "Not policy holder.");
        _;
    }
    
    constructor(
        SRXToken _token,
        address _operator,
        address _holder,
        uint _target,
        uint _term,
        uint _deposit,
        uint _riskRateBIPS,
        uint _overdueRateBIPS
    ) {
        token = _token;
        operator = _operator;
        holder = _holder;
        target = _target;
        term = _term;
        deposit = _deposit;
        riskRateBIPS = _riskRateBIPS;
        overdueRateBIPS = _overdueRateBIPS;
        
        inceptionDate = block.timestamp;
        maturityDate = inceptionDate + term * 30 days;
        
        status = PolicyStatus.ACTIVE;
        period = 0;
        savings = _deposit;
        premiumsPaid = 0;
        
        payments = new uint[](term+1);
        for(uint i = 0; i <= _term; i++) {
            payments[i] = inceptionDate + i * 30 days;
        }
    }
    
    /**
     * @dev Allows for migration of operator contract by transferring operator status.
     */
    function updateOperator(address newOperator) public onlyOperator returns (bool) {
        operator = newOperator;
        return true;
    }
    
    function calculateSavingsAnnuity() public view returns (uint) {
        if(period == 0) {
            return 0;
        }
        
        return (target - savings) / (term - period + 1);
    }
    
    function calculateCoverPremium() public view returns (uint) {
        return (target - (savings + calculateSavingsAnnuity())) * riskRateBIPS / 10000 / 12;
    }
    
    function calculateOverdueFee() public view returns (uint) {
        if(!paymentIsOverdue()) {
            return 0;
        }
        
        return (calculateSavingsAnnuity() + calculateCoverPremium()) * overdueRateBIPS / 10000;
    }
    
    /**
     * @dev Returns the value of the payment due.
     * For the inception period only cover is paid.
     * For the final period only the annuity is paid as the cover amount is zero.
     * Includes any overdue fees if applicable.
     */
    function calculatePayment() public view returns (uint) {
        uint _annuity = calculateSavingsAnnuity();
        uint _premium = calculateCoverPremium();
        uint _overdue = calculateOverdueFee();
        uint paymentDue = _annuity + _premium + _overdue;
        if(period == 0) {
            paymentDue += deposit;
        }
        return paymentDue;
    }
    
    function paymentSchedule() public view returns (uint[] memory) {
        return payments;
    }
    
    /**
     * @dev Returns true if and only if a payment is currently due.
     * It allows for payments to be made up to 48 hours in advance.
     */
    function paymentIsDue() public view returns (bool) {
        if(status != PolicyStatus.ACTIVE) {
            return false;
        }
        
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
    function paymentIsOverdue() public view returns (bool) {
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
     */
    function payPolicy() public onlyPolicyHolder returns (bool) {
        require(status == PolicyStatus.ACTIVE, "Policy is no longer active.");
        require(paymentIsDue(), "No payment is currently due.");
        
        uint paymentDue = 0;
        uint _annuity = calculateSavingsAnnuity();
        uint _premium = calculateCoverPremium();
        
        if(period == 0) {
            paymentDue += deposit;
            savings += deposit;
        }
        paymentDue += _annuity + _premium;
        savings += _annuity;
        premiumsPaid += _premium;
        
        if(paymentIsOverdue()) {
            uint _overdue = calculateOverdueFee();
            paymentDue += _overdue;
            // TODO: move overdue fee to Risk Based Capital or Operations Capital
        }
        
        require(token.balanceOf(holder) >= paymentDue, "Insufficient tokens to pay policy.");
        require(token.approvedTransfer(holder, address(this), paymentDue), "Token transfer failed.");
        
        // TODO: move annuity to Savings Capital (yield farm) and premium amount to Risk Based Capital (MCR)
        
        period++;
        if(period == term) {
            status = PolicyStatus.MATURED;
            // TODO: emit event
            // TODO: savings payout
        }
        
        return true;
    }
}
