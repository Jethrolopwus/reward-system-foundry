// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/RewardSystem.sol";

contract RewardSystemTest is Test {
    RewardSystem rewardSystem;

    address user1 = address(0x123);
    address user2 = address(0x456);

    function setUp() public {
        rewardSystem = new RewardSystem();
    }

    function testAddPoints() public {
        rewardSystem.addPoints(user1, 100);
        uint256 balance = rewardSystem.getBalance(user1);
        assertEq(balance, 100, "User1 balance should be 100");

        rewardSystem.addPoints(user1, 50);
        balance = rewardSystem.getBalance(user1);
        assertEq(balance, 150, "User1 balance should be 150");
    }

    function testRedeemPoints() public {
        rewardSystem.addPoints(user1, 200);

        vm.prank(user1); 
        rewardSystem.redeemPoints(100);

        uint256 balance = rewardSystem.getBalance(user1);
        assertEq(balance, 100, "User1 balance should be 100 after redeeming 100 points");
    }

    function testRedeemInsufficientPoints() public {
        rewardSystem.addPoints(user1, 50);

        vm.prank(user1);
        vm.expectRevert(abi.encodeWithSelector(RewardSystem.InsufficientPoints.selector, 50, 100));
        rewardSystem.redeemPoints(100);
    }

    function testAddZeroPoints() public {
        vm.expectRevert(RewardSystem.AmountMustBeGreaterThanZero.selector);
        rewardSystem.addPoints(user1, 0);
    }

    function testRedeemZeroPoints() public {
       
        vm.expectRevert(RewardSystem.AmountMustBeGreaterThanZero.selector);
        vm.prank(user1);
        rewardSystem.redeemPoints(0);
    }

    function testMultipleUsers() public {
      
        rewardSystem.addPoints(user1, 100);
        rewardSystem.addPoints(user2, 200);

     
        uint256 balance1 = rewardSystem.getBalance(user1);
        uint256 balance2 = rewardSystem.getBalance(user2);

        assertEq(balance1, 100, "User1 balance should be 100");
        assertEq(balance2, 200, "User2 balance should be 200");

       
        vm.prank(user2);
        rewardSystem.redeemPoints(50);

        balance2 = rewardSystem.getBalance(user2);
        assertEq(balance2, 150, "User2 balance should be 150 after redeeming 50 points");
    }
}
