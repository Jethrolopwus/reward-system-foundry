// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RewardSystem {
    mapping(address => uint256) private balances;

    error AmountMustBeGreaterThanZero();
    error InsufficientPoints(uint256 available, uint256 required);

    event PointsAdded(address indexed user, uint256 amount);
    event PointsRedeemed(address indexed user, uint256 amount);
  
    function addPoints(address user, uint256 amount) external {
        if (amount == 0) {
            revert AmountMustBeGreaterThanZero();
        }

        balances[user] += amount;
        emit PointsAdded(user, amount);
    }


    function redeemPoints(uint256 amount) external {
        if (amount == 0) {
            revert AmountMustBeGreaterThanZero();
        }

        uint256 userBalance = balances[msg.sender];
        if (userBalance < amount) {
            revert InsufficientPoints(userBalance, amount);
        }

        balances[msg.sender] -= amount;
        emit PointsRedeemed(msg.sender, amount);
    }


    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }
}

