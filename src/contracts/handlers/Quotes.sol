// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract Quotes {
    struct CoverQuote {
        uint target;
        uint term;
        uint deposit;
        
        uint savingsAnnuity;
        uint initialCoverPremium;
        uint firstInstallment;
    }
    
    function calculateCoverPremium(uint _target, uint _deposit, uint _riskRateBIPS) internal pure returns (uint) {
        return (_target - _deposit) * _riskRateBIPS / 10000 / 12;
    }
    
    function calculateSavingsAnnuity(uint _target, uint _term, uint _deposit) internal pure returns (uint) {
        return (_target - _deposit) / _term;
    }
    
    function _coverQuote(
        uint _target,
        uint _term,
        uint _deposit,
        uint _riskRateBIPS
    ) internal pure returns(CoverQuote memory) {
        uint _savingsAnnuity = calculateSavingsAnnuity(_target, _term, _deposit);
        uint _coverPremium = calculateCoverPremium(_target, _deposit, _riskRateBIPS);
        uint _firstInstallment = _deposit + _coverPremium;
        CoverQuote memory q = CoverQuote({
            target: _target,
            term: _term,
            deposit: _deposit,
            savingsAnnuity: _savingsAnnuity,
            initialCoverPremium: _coverPremium,
            firstInstallment: _firstInstallment
        });
        return q;
    }
}