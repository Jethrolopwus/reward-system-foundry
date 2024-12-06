// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/RewardSystem.sol";

contract RewardSystemScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

      
        RewardSystem rewardSystem = new RewardSystem();

     
        address user1 = address(0x123);
        address user2 = address(0x456);

        rewardSystem.addPoints(user1, 100);
        rewardSystem.addPoints(user2, 200);

        vm.prank(user1);
        rewardSystem.redeemPoints(50);

        vm.stopBroadcast();
    }
}

