// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/YSABadge.sol";
import "../src/YSADiscipline.sol";

contract YSATest is Test {
    YSABadge badge;
    YSADiscipline discipline;

    address orchestrator = address(this);
    address founder = address(0xF001);

    function setUp() public {
        badge = new YSABadge();
        discipline = new YSADiscipline(address(badge));

        badge.setDisciplineContract(address(discipline));

        vm.deal(founder, 10 ether);
    }

    function test_FullCycle_StakeCompleteGetBadge() public {
        vm.prank(founder);
        discipline.stake{value: 0.05 ether}();

        (uint256 start, uint8 challenges, bool active, bool complete, uint256 staked) = discipline.getCycleInfo(founder);
        assertEq(active, true);
        assertEq(staked, 0.05 ether);

        discipline.completeChallenge(founder);
        discipline.completeChallenge(founder);
        discipline.completeChallenge(founder);

        uint256 balBefore = founder.balance;
        discipline.completeCycle(founder);
        uint256 balAfter = founder.balance;

        assertEq(balAfter - balBefore, 0.05 ether);
        assertEq(badge.levelOf(founder), 1);

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

        assertEq(balAfter - balBefore, 0.5 ether);
        assertEq(discipline.rewardPool(), 0.5 ether);
        assertEq(badge.levelOf(founder), 0);
    }

    function test_BelowMinStake_Reverts() public {
        vm.prank(founder);
        vm.expectRevert(YSADiscipline.BelowMinStake.selector);
        discipline.stake{value: 0.001 ether}();
    }

    function test_Soulbound_TransferReverts() public {
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
        vm.prank(founder);
        discipline.stake{value: 0.01 ether}();
        discipline.completeChallenge(founder);
        discipline.completeChallenge(founder);
        discipline.completeChallenge(founder);
        discipline.completeCycle(founder);
        assertEq(badge.levelOf(founder), 1);

        vm.prank(founder);
        discipline.stake{value: 0.01 ether}();
        discipline.completeChallenge(founder);
        discipline.completeChallenge(founder);
        discipline.completeChallenge(founder);
        discipline.completeCycle(founder);
        assertEq(badge.levelOf(founder), 2);
    }
}
