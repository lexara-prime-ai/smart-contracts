// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Coin {
    address public minter;
    mapping (address => unit) public balances;

    event Sent(address from, address to, unit amount);

    constructor() {
        minter = msg.sender;
    }

    function mint(address receiver, unit amount) public {
        require(msg.sender == minter);
        balances[receiver] +=amount;
    }

    error InsufficientBalance(unit requested, unit available);

    function send(address receiver, unit amount) public {
        if (amount > balances[msg.sender])
        revert InsufficientBalance({
            requested: amount,
            available: balances[msg.sender]
        });

        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}