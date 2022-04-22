// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;

contract Token {
    string public constant name = "Cap Token";
    string public constant symbol = "CAP";
    uint8  public constant decimals = 0;
    uint256 public totalSupply = 10000;

    address public owner;

    mapping(address => uint256) internal balances;

    // --- Math ---
    function add(uint x, uint y) internal pure returns (uint z) {
        require((z = x + y) >= x);
    }
    function sub(uint x, uint y) internal pure returns (uint z) {
        require((z = x - y) <= x);
    }

    constructor() {
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    function transfer(address to, uint256 amt) external {
        require(balances[msg.sender] >= amt, "Not enough tokens");

        balances[msg.sender] = sub(balances[msg.sender], amt);
        balances[to] = add(balances[to], amt);
    }

    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }

    function giveMeTheMoney(uint256 amount) external {
        require(msg.sender == owner, "Only owner allowed");

        balances[owner] = add(balances[owner], amount);
        totalSupply += add(totalSupply, amount);
    }
}
