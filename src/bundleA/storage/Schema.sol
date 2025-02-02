// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

/// @custom:storage-location erc7201:investment.platform.globalstate
library Schema {
    struct GlobalState {
        mapping(address => Investor) investors;
        mapping(uint256 => InvestmentPool) pools;
        mapping(address => ProjectOwner) projectOwners;
        mapping(uint256 => Distribution) distributions;
        address tokenAddress;
        uint256 nextPoolID;
        uint256 nextDistributionID;
        bool initialized;
    }

    struct Investor {
        uint256 totalInvested;
        uint256 claimableRewards;
        mapping(uint256 => uint256) poolInvestments;
    }

    struct ProjectOwner {
        uint256 totalBorrowed;
        uint256 totalRepaid;
        uint256 activeLoans;
    }

    struct InvestmentPool {
        uint256 poolID;
        uint256 totalDeposit;
        uint256 maxInvestment;
        uint256 lockDuration;
        uint256 interestRate;
        uint256 totalBorrowed;
        uint256 totalRepaid;
        bool isActive;
    }

    struct Distribution {
        uint256 distributionID;
        uint256 poolID;
        uint256 amount;
        uint256 timestamp;
    }
}
