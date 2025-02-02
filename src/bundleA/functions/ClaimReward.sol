// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../storage/Schema.sol";
import "../storage/Storage.sol";

contract ClaimReward {
    function claimReward() external {
        Schema.GlobalState storage $s = Storage.state();
        uint256 reward = $s.investors[msg.sender].claimableRewards;
        require(reward > 0, "No rewards to claim");

        $s.investors[msg.sender].claimableRewards = 0;
        payable(msg.sender).transfer(reward);

        emit RewardClaimed(msg.sender, reward);
    }

    event RewardClaimed(address indexed investor, uint256 amount);
}
