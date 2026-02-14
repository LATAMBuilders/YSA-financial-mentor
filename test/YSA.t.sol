// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/YSABadge.sol";
import "../src/YSADiscipline.sol";
import "../src/YSAGrantPool.sol";

contract YSATest is Test {
    YSABadge badge;
    YSADiscipline discipline;
    YSAGrantPool grantPool;

    address orchestrator = address(this);
    address founder = address(0xF001);
    address poolCreator = address(0xP001);

    function setUp() public {
        badge = new YSABadge();
        discipline = new YSADiscipline(address(badge));
        grantPool = new YSAGrantPool(address(badge));

        badge.setDisciplineContract(address(discipline));
        // orchestrator is address(this) by default (deployer)

        vm.deal(founder, 10 ether);
        vm.deal(poolCreator, 10 ether);
    }

    function test_FullCycle_StakeCompleteGetBadge() public {
        // Founder stakes
        vm.prank(founder);
        discipline.stake{value: 0.05 ether}();

        (uint256 start, uint8 challenges, bool active, bool complete, uint256 staked) = discipline.getCycleInfo(founder);
        assertEq(active, true);
        assertEq(staked, 0.05 ether);

        // Complete 3 challenges
        discipline.completeChallenge(founder);
        discipline.completeChallenge(founder);
        discipline.completeChallenge(founder);

        // Complete cycle
        uint256 balBefore = founder.balance;
        discipline.completeCycle(founder);
        uint256 balAfter = founder.balance;

        // Stake returned
        assertEq(balAfter - balBefore, 0.05 ether);

        // Badge minted at level 1
        assertEq(badge.levelOf(founder), 1);

        // Cycle marked complete
        (, , active, complete,) = discipline.getCycleInfo(founder);
        assertEq(active, false);
        assertEq(complete, true);
    }

    function test_Slash() public {
        vm.prank(founder);
        discipline.stake{value: 1 ether}();

        uint256 balBefore = founder.balance;
        discipline.slash(founder);
        uint256 balAfter = founder.balance;

        // Gets back 50%
        assertEq(balAfter - balBefore, 0.5 ether);
        // Reward pool gets 50%
        assertEq(discipline.rewardPool(), 0.5 ether);
        // No badge
        assertEq(badge.levelOf(founder), 0);
    }

    function test_ApplyWithoutBadge_Reverts() public {
        // Create pool
        vm.prank(poolCreator);
        grantPool.createPool{value: 5 ether}(1, "LATAM Builders Fund");

        // Founder tries to apply without badge
        vm.prank(founder);
        vm.expectRevert(YSAGrantPool.InsufficientLevel.selector);
        grantPool.applyToPool(1);
    }

    function test_FullFlow_CycleToGrant() public {
        // Complete a cycle first
        vm.prank(founder);
        discipline.stake{value: 0.01 ether}();
        discipline.completeChallenge(founder);
        discipline.completeChallenge(founder);
        discipline.completeChallenge(founder);
        discipline.completeCycle(founder);

        assertEq(badge.levelOf(founder), 1);

        // Create pool
        vm.prank(poolCreator);
        grantPool.createPool{value: 5 ether}(1, "LATAM Builders Fund");

        // Apply
        vm.prank(founder);
        grantPool.applyToPool(1);

        // Approve grant
        uint256 balBefore = founder.balance;
        vm.prank(poolCreator);
        grantPool.approveGrant(1, founder, 2 ether);
        uint256 balAfter = founder.balance;

        assertEq(balAfter - balBefore, 2 ether);
    }

    function test_BelowMinStake_Reverts() public {
        vm.prank(founder);
        vm.expectRevert(YSADiscipline.BelowMinStake.selector);
        discipline.stake{value: 0.001 ether}();
    }

    function test_Soulbound_TransferReverts() public {
        // Get a badge first
        vm.prank(founder);
        discipline.stake{value: 0.01 ether}();
        discipline.completeChallenge(founder);
        discipline.completeChallenge(founder);
        discipline.completeChallenge(founder);
        discipline.completeCycle(founder);

        uint256 tokenId = badge.tokenOfFounder(founder);

        vm.prank(founder);
        vm.expectRevert(YSABadge.Soulbound.selector);
        badge.transferFrom(founder, address(0xBEEF), tokenId);
    }

    function test_BadgeUpgrade() public {
        // Complete first cycle
        vm.prank(founder);
        discipline.stake{value: 0.01 ether}();
        discipline.completeChallenge(founder);
        discipline.completeChallenge(founder);
        discipline.completeChallenge(founder);
        discipline.completeCycle(founder);
        assertEq(badge.levelOf(founder), 1);

        // Complete second cycle → upgrade
        vm.prank(founder);
        discipline.stake{value: 0.01 ether}();
        discipline.completeChallenge(founder);
        discipline.completeChallenge(founder);
        discipline.completeChallenge(founder);
        discipline.completeCycle(founder);
        assertEq(badge.levelOf(founder), 2);
    }
}
