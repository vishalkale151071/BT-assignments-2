// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {AlumniAssociation, Alumni} from "../src/AlumniAssociation.sol";

contract Admin_only is Test {
    AlumniAssociation alumniAssociation;
    address alumni = 0x4E9262D749f50d2817E54b411272e1E71Be7B20A;

    function setUp() public {
        alumniAssociation = new AlumniAssociation();
    }

    function test_mintFail() public {
        Alumni memory data = Alumni({passingYear: 2021, name: "Alice", location: "USA", catoegory: "Gold"});
        address not_admin = makeAddr("not_admin");
        vm.startPrank(not_admin);

        vm.expectRevert(bytes("only admin can mint"));
        alumniAssociation.mint(alumni, data);
    }

    function test_addGradeFail() public {
        Alumni memory data = Alumni({passingYear: 2021, name: "Alice", location: "USA", catoegory: "Gold"});

        alumniAssociation.mint(alumni, data);

        address not_admin = makeAddr("not_admin");
        vm.startPrank(not_admin);

        vm.expectRevert(bytes("only admin can grade points"));
        alumniAssociation.gradePoints(1, "Conference Paper");
    }
}
