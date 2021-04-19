// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract Claim {
    enum ClaimStatus {PENDING, VOTING, REVEALING, WITHDRAWN, APPROVED, DECLINED, EXPIRED}
    enum Outcome {DECLINE, APPROVE}
    
    address internal operator;                      // operator address (master contract)
    mapping(address => bool) internal assessors;    // claim assessors for this claim
    
    // initial state data
    address public policy;
    address public policyHolder;
    uint public lossAmount;
    bytes32 public proofOfLoss;     // keccak256 (TODO: exact format TBD)
    uint public timestamp;          // claim registration timestamp (Unix epoch)
    
    // current state
    ClaimStatus public status;
    
    // votes (commit-reveal scheme)
    uint8 public assessorsAssigned;
    mapping(address => bytes32) public blindedVotes;
    uint8 public blindTally;
    mapping(address => Outcome) public revealedVotes;
    mapping(Outcome => uint8) public voteTally;
    
    modifier onlyOperator() {
        if(operator != address(0))
            require(msg.sender == operator, "Not operator.");
        _;
    }
    
    modifier onlyPolicyHolder() {
        if(address(msg.sender) != operator)
            require(address(msg.sender) == policyHolder, "Not policy holder.");
        _;
    }
    
    modifier onlyAssessors() {
        if(address(msg.sender) != operator)
            require(assessors[msg.sender], "Not assessor.");
        _;
    }
    
    constructor(
        address _operator,
        address _policy,
        address _policyHolder,
        uint _lossAmount,
        bytes32 _proofOfLoss
    ) {
        operator = _operator;
        policy = _policy;
        policyHolder = _policyHolder;
        lossAmount = _lossAmount;
        proofOfLoss = _proofOfLoss;
        
        timestamp = block.timestamp;
        
        status = ClaimStatus.PENDING;
        assessorsAssigned = 0;
    }
    
    /**
     * @dev Allows for migration of operator contract by transferring operator status.
     */
    function updateOperator(address newOperator) public onlyOperator returns (bool) {
        operator = newOperator;
        return true;
    }
    
    /**
     * @dev Allows for the operator to set assessors.
     */
    function assignAssessor(address _assessor) internal onlyOperator returns (bool) {
        assessors[_assessor] = true;
        assessorsAssigned++;
        if(assessorsAssigned >= 3) {
            status = ClaimStatus.VOTING;
            // TODO: emit event
        }
        return true;
    }
    
    /**
     * @dev Allows the policy holder to withdraw the claim. Stake will be forfeited.
     */
    function withdraw() public onlyPolicyHolder returns (bool) {
        status = ClaimStatus.WITHDRAWN;
        // TODO: emit event
        return true;
    }
    
    /**
     * @dev Registers the blinded vote of the sender (must be an assessor).
     * _blindVote is a keccak256 hash of the form:
     * keccak256(abi.encodePacked(address, Outcome, secret));
     */
    function blindVote(bytes32 _blindedVote) public onlyAssessors returns (bool) {
        blindedVotes[msg.sender] = _blindedVote;
        blindTally++;
        if(blindTally >= 3) {
            status = ClaimStatus.REVEALING;
            // TODO: emit event
        }
        return true;
    }
    
    /**
     * @dev Registers the revealed vote of the sender (must be an assessor).
     * The given inputs must result in the recorded blinded vote of the sender to be considered.
     * Votes are tallied and when the final vote is in the outcome is determined.
     */
    function revealVote(Outcome _vote, uint _secret) public onlyAssessors returns (bool) {
        // Reveal vote must match Commit vote
        require(blindedVotes[msg.sender] == keccak256(abi.encodePacked(msg.sender, _vote, _secret)), "Reveal does not match Commit.");
        revealedVotes[msg.sender] = _vote;  // Record vote
        voteTally[_vote]++;                 // Tally vote
        
        // Check if voting completed (tribunal = 3 votes)
        if(voteTally[Outcome.APPROVE] + voteTally[Outcome.DECLINE] >= 3) {
            if(voteTally[Outcome.APPROVE] > voteTally[Outcome.DECLINE]) {
                status = ClaimStatus.APPROVED;
                // TODO: emit event
            } else {
                status = ClaimStatus.DECLINED;
                // TODO: emit event
            }
            
        }
        return true;
    }
}
