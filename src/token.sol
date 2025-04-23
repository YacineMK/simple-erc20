// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Token {
    string public tokenName = "3issa Token";
    string public tokenSymbol = "3IS";
    uint8 public decimals = 18;
    uint256 public totalSupply; 

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    mapping(address => bool) public isBlacklisted;


    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Blacklist(address indexed account);

    constructor() {
        uint256 initialSupply = 10; 
        totalSupply = initialSupply * 10 ** uint256(decimals);
        balanceOf[msg.sender] = totalSupply;
    }

    function getBalance(address account) public view returns (uint256) {
        require(account != address(0), "Get balance of the zero address");
        return balanceOf[account];
    }


    function transfer(address from, address to, uint256 value) public {
        require(from != address(0), "Transfer from the zero address");
        require(to != address(0), "Transfer to the zero address");
        require(value > 0, "Transfer value must be greater than 0");
        require(balanceOf[from] >= value, "Insufficient balance");

        balanceOf[from] -= value;
        balanceOf[to] += value;

        emit Transfer(from, to, value);
    }


    function aprove(address owner, address spender, uint256 value) public {
        require(owner != address(0), "Approve from the zero address");
        require(spender != address(0), "Approve to the zero address");
        require(value > 0, "Approve value must be greater than 0");
        require(!isBlacklisted[spender], "Spender is blacklisted");

        allowance[owner][spender] = value;

        emit Approval(owner, spender, value);
    }

    function blockAddress (address account) public {
        require(account != address(0), "Blacklist the zero address");
        require(!isBlacklisted[account], "Account is already blacklisted");

        isBlacklisted[account] = true;

        emit Blacklist(account);
    }

}
