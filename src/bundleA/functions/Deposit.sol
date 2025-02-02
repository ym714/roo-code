// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../storage/Schema.sol";
import "../storage/Storage.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Deposit {
    function deposit(uint256 poolID, uint256 amount) external {
        Schema.GlobalState storage $s = Storage.state();
        require($s.pools[poolID].isActive, "Pool is not active");

        IERC20 token = IERC20($s.tokenAddress);
        require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed");

        $s.investors[msg.sender].totalInvested += amount;
        $s.investors[msg.sender].poolInvestments[poolID] += amount;
        $s.pools[poolID].totalDeposit += amount;

        emit Deposited(msg.sender, poolID, amount);
    }

    event Deposited(address indexed investor, uint256 indexed poolID, uint256 amount);
}
