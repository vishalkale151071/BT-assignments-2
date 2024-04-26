// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {AlumniAssociation} from "../src/AlumniAssociation.sol";
import "forge-std/console2.sol";

contract Deploy is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYMENT_KEY");
        vm.startBroadcast(deployerPrivateKey);
        AlumniAssociation alumniAssociation = new AlumniAssociation();
        vm.stopBroadcast();

        console2.log("Alumni Association deployed at address: ", address(alumniAssociation));
    }
}
