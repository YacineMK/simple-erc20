// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Token} from "../src/token.sol";

contract TokenScript is Script {
    Token public token;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        token = new Token();

        vm.stopBroadcast();
    }
}
