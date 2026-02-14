// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./YSABadge.sol";

/// @title YSADiscipline — Stake-based discipline cycles for LATAM founders
contract YSADiscipline {
    struct Cycle {
        uint256 stakeAmount;
        uint256 startTime;
        uint8 challengesCompleted;
        bool isActive;
        bool isComplete;
    }

    uint256 public constant MIN_STAKE = 0.01 ether;
    uint256 public constant CYCLE_DURATION = 7 days;
    uint256 public constant REQUIRED_CHALLENGES = 3;
    uint256 public constant SLASH_BPS = 5000; // 50%

    address public orchestrator;
    address public owner;
    YSABadge public badge;

    uint256 public rewardPool;
    mapping(address => Cycle) public cycles;
    mapping(address => uint256) public completedCycles;

    event Staked(address indexed founder, uint256 amount);
    event ChallengeCompleted(address indexed founder, uint8 total);
    event CycleCompleted(address indexed founder);
    event Slashed(address indexed founder, uint256 slashedAmount);

    error AlreadyActive();
    error NotActive();
    error BelowMinStake();
    error NotOrchestrator();
    error OnlyOwner();
    error AllChallengesDone();
    error ChallengesIncomplete();

    modifier onlyOrchestrator() {
        if (msg.sender != orchestrator) revert NotOrchestrator();
        _;
    }

    constructor(address _badge) {
        owner = msg.sender;
        orchestrator = msg.sender;
        badge = YSABadge(_badge);
    }

    function setOrchestrator(address _orch) external {
        if (msg.sender != owner) revert OnlyOwner();
        orchestrator = _orch;
    }

    function stake() external payable {
        if (cycles[msg.sender].isActive) revert AlreadyActive();
        if (msg.value < MIN_STAKE) revert BelowMinStake();

        cycles[msg.sender] = Cycle({
            stakeAmount: msg.value,
            startTime: block.timestamp,
            challengesCompleted: 0,
            isActive: true,
            isComplete: false
        });

        emit Staked(msg.sender, msg.value);
    }

    function completeChallenge(address founder) external onlyOrchestrator {
        Cycle storage c = cycles[founder];
        if (!c.isActive) revert NotActive();
        if (c.challengesCompleted >= REQUIRED_CHALLENGES) revert AllChallengesDone();
        c.challengesCompleted++;
        emit ChallengeCompleted(founder, c.challengesCompleted);
    }

    function completeCycle(address founder) external onlyOrchestrator {
        Cycle storage c = cycles[founder];
        if (!c.isActive) revert NotActive();
        if (c.challengesCompleted < REQUIRED_CHALLENGES) revert ChallengesIncomplete();

        c.isActive = false;
        c.isComplete = true;
        completedCycles[founder]++;

        // Return stake
        uint256 amount = c.stakeAmount;
        c.stakeAmount = 0;

        // Mint or upgrade badge
        if (badge.levelOf(founder) == 0) {
            badge.mint(founder, 1);
        } else {
            badge.upgrade(founder);
        }

        (bool ok,) = founder.call{value: amount}("");
        require(ok, "Transfer failed");

        emit CycleCompleted(founder);
    }

    function slash(address founder) external onlyOrchestrator {
        Cycle storage c = cycles[founder];
        if (!c.isActive) revert NotActive();

        c.isActive = false;
        uint256 slashAmount = (c.stakeAmount * SLASH_BPS) / 10000;
        uint256 refund = c.stakeAmount - slashAmount;
        c.stakeAmount = 0;

        rewardPool += slashAmount;

        if (refund > 0) {
            (bool ok,) = founder.call{value: refund}("");
            require(ok, "Transfer failed");
        }

        emit Slashed(founder, slashAmount);
    }

    function getCycleInfo(address founder)
        external
        view
        returns (uint256 startTime, uint8 challengesCompleted, bool isActive, bool isComplete, uint256 stakeAmount)
    {
        Cycle storage c = cycles[founder];
        return (c.startTime, c.challengesCompleted, c.isActive, c.isComplete, c.stakeAmount);
    }

    receive() external payable {
        rewardPool += msg.value;
    }
}
