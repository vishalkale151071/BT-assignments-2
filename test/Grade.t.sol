// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {AlumniAssociation, Alumni} from "../src/AlumniAssociation.sol";

contract Grade is Test {
    AlumniAssociation alumniAssociation;
    address alumni = 0x4E9262D749f50d2817E54b411272e1E71Be7B20A;

    function setUp() public {
        alumniAssociation = new AlumniAssociation();
    }

    function test_grade() public {
        Alumni memory data = Alumni({passingYear: 2021, name: "Alice", location: "USA", catoegory: "Gold"});

        alumniAssociation.mint(alumni, data);

        assertEq(alumniAssociation.pointsOf(1), 0);

        alumniAssociation.gradePoints(1, "Journal Paper");

        assertEq(alumniAssociation.pointsOf(1), 15);
    }

    function test_gradeFail() public {
        Alumni memory data = Alumni({passingYear: 2021, name: "Alice", location: "USA", catoegory: "Gold"});

        alumniAssociation.mint(alumni, data);

        assertEq(alumniAssociation.pointsOf(1), 0);

        vm.expectRevert(bytes("Invalid assignment"));
        alumniAssociation.gradePoints(1, "IEEE Paper");
    }
}
