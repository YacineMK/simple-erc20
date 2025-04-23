// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Token.sol";

contract TokenTest is Test {
    Token token;
    address user1;
    address user2;

    function setUp() public {
        token = new Token();

        user1 = address(0x1);
        user2 = address(0x2);


        token.transfer(address(this), user1, 1 ether);
    }


    function testTransfer() public {

        vm.prank(user1); 
        token.transfer(user1, user2, 0.5 ether);

        assertEq(token.balanceOf(user1), 0.5 ether);
        assertEq(token.balanceOf(user2), 0.5 ether);
    }

    function testApprove() public {
        vm.prank(user1);
        token.aprove(user1, user2, 1 ether);

        assertEq(token.allowance(user1, user2), 1 ether);
    }

    function testBlacklist() public {
        token.blockAddress(user2);

        assertTrue(token.isBlacklisted(user2));

        vm.expectRevert("Spender is blacklisted");
        token.aprove(user1, user2, 1 ether);
    }
}
