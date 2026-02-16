// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "./YSABadge.sol";

/// @title YSAGrantPool — Grant pools requiring YSA badge reputation
contract YSAGrantPool {
    struct Pool {
        address creator;
        string name;
        uint256 minLevel;
        uint256 balance;
        bool active;
    }

    struct Application {
        bool applied;
        bool approved;
        uint256 amountGranted;
    }

    YSABadge public badge;
    uint256 public nextPoolId = 1;

    mapping(uint256 => Pool) public pools;
    mapping(uint256 => mapping(address => Application)) public applications;

    event PoolCreated(uint256 indexed poolId, address indexed creator, string name, uint256 minLevel);
    event Applied(uint256 indexed poolId, address indexed founder);
    event GrantApproved(uint256 indexed poolId, address indexed founder, uint256 amount);

    error InsufficientLevel();
    error NotPoolCreator();
    error AlreadyApplied();
    error NotApplied();
    error InsufficientPoolBalance();
    error PoolNotActive();
    error NoValue();

    constructor(address _badge) {
        badge = YSABadge(_badge);
    }

    function createPool(uint256 minLevel, string calldata _name) external payable {
        if (msg.value == 0) revert NoValue();
        uint256 poolId = nextPoolId++;
        pools[poolId] = Pool({
            creator: msg.sender,
            name: _name,
            minLevel: minLevel,
            balance: msg.value,
            active: true
        });
        emit PoolCreated(poolId, msg.sender, _name, minLevel);
    }

    function applyToPool(uint256 poolId) external {
        Pool storage p = pools[poolId];
        if (!p.active) revert PoolNotActive();
        if (badge.levelOf(msg.sender) < p.minLevel) revert InsufficientLevel();
        if (applications[poolId][msg.sender].applied) revert AlreadyApplied();

        applications[poolId][msg.sender].applied = true;
        emit Applied(poolId, msg.sender);
    }

    function approveGrant(uint256 poolId, address founder, uint256 amount) external {
        Pool storage p = pools[poolId];
        if (msg.sender != p.creator) revert NotPoolCreator();
        if (!applications[poolId][founder].applied) revert NotApplied();
        if (p.balance < amount) revert InsufficientPoolBalance();

        p.balance -= amount;
        applications[poolId][founder].approved = true;
        applications[poolId][founder].amountGranted = amount;

        (bool ok,) = founder.call{value: amount}("");
        require(ok, "Transfer failed");

        emit GrantApproved(poolId, founder, amount);
    }

    function getPool(uint256 poolId) external view returns (address creator, string memory _name, uint256 minLevel, uint256 balance, bool active) {
        Pool storage p = pools[poolId];
        return (p.creator, p.name, p.minLevel, p.balance, p.active);
    }
}
