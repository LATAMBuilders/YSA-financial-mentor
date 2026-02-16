// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "forge-std/Script.sol";
import "../src/YSABadge.sol";
import "../src/YSADiscipline.sol";
import "../src/YSAGrantPool.sol";

contract Deploy is Script {
    function run() external {
        vm.startBroadcast();

        YSABadge badge = new YSABadge();
        YSADiscipline discipline = new YSADiscipline(address(badge));
        YSAGrantPool grantPool = new YSAGrantPool(address(badge));

        badge.setDisciplineContract(address(discipline));

        console.log("YSABadge:", address(badge));
        console.log("YSADiscipline:", address(discipline));
        console.log("YSAGrantPool:", address(grantPool));

        vm.stopBroadcast();
    }
}
