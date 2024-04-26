// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {AlumniAssociation, Alumni} from "../src/AlumniAssociation.sol";
import "forge-std/console2.sol";

contract Deploy is Script {
    address alumni = 0x4E9262D749f50d2817E54b411272e1E71Be7B20A;
    address contractAddress = 0x6c7aCc80EdAB86fCCA266AB49135F3BBA08961d4;

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYMENT_KEY");
        vm.startBroadcast(deployerPrivateKey);
        AlumniAssociation alumniAssociation = AlumniAssociation(0x6c7aCc80EdAB86fCCA266AB49135F3BBA08961d4);
        alumniAssociation.mint(alumni, Alumni({passingYear: 2021, name: "Alice", location: "WILP", catoegory: "Masters"}));
        vm.stopBroadcast();

        console2.log("Alumni Association deployed at address: ", address(alumniAssociation));
    }
}
