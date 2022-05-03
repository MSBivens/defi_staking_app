// This contract will need to allow for staking, withdrawing, and claming reward

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

impport "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// Custom errors, more gas efficient
error Staking__TransferFailed

contract Staking {
    IERC20 public s_stakingToken;

    // someones address -> how much they staked
    mapping(address => uint256) public s_balances;

    uint256 public s_totalSupply;

    constructor(address stakingToken) {
        s_stakingToken = IERC20(stakingToken);
    }

    function stake (uint256 amount) {
        // Keep track of how much this user has stakedd
        // Keep track of how much token we have total
        // Transfer the tokens to this contract
        s_balances[msg.sender] = s_balances[msg.sender] + amount;
        s_totalSupply = s_totalSupply + amount;
        // emit event
        bool success = s_stakingToken.transferFrom(msg.sender, address(this), amount);
        if(!success) {
            revert Staking__TransferFailed();
        }
    }

    function withdraw(uint256 amount) external {
        s_balances[msg.sender] = s_balances[msg.sender] - amount;
        s_totalSupply = s_totalSupply - amount;
        bool success = s_stakingToken.transfer(msg.sender, amount);
        if(!success) {
            revert Staking__TransferFailed();
        }
    }

    function claimReward() external {
        // How much reward do they get?
        // The contract is going to emit X tokens per second
        // Tokens dispersed to all stakers
        
        // 100 reward tokens / second
        // staked: 50 staked tokens, 20 staked tokens, 30 staked tokens
        // reward: 50 reward tokens, 20 reward tokens, 30 reward tokens
        
        // staked: 100, 50, 20, 30 (total = 200)
        // rewards: 50, 25, 10, 15
        
    }
}