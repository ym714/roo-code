// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../storage/Schema.sol";
import "../storage/Storage.sol";

contract DistributeRewards {
    function distributeRewards(uint256 poolID, uint256 amount) external {
        Schema.GlobalState storage $s = Storage.state();
        require($s.pools[poolID].isActive, "Pool is not active");

        uint256 totalDeposit = $s.pools[poolID].totalDeposit;
        require(totalDeposit > 0, "No deposits in pool");

        for (uint256 i = 0; i < $s.nextPoolID; i++) {
            address investor = msg.sender;
            uint256 investedAmount = $s.investors[investor].poolInvestments[poolID];
            if (investedAmount > 0) {
                uint256 reward = (investedAmount * amount) / totalDeposit;
                $s.investors[investor].claimableRewards += reward;
            }
        }

        emit RewardsDistributed(poolID, amount);
    }

    event RewardsDistributed(uint256 indexed poolID, uint256 amount);
}
