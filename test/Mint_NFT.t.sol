// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {AlumniAssociation, Alumni} from "../src/AlumniAssociation.sol";

contract Mint_NFT is Test {
    AlumniAssociation alumniAssociation;
    address alumni = 0x4E9262D749f50d2817E54b411272e1E71Be7B20A;

    function setUp() public {
        alumniAssociation = new AlumniAssociation();
    }

    function test_mint() public {
        Alumni memory data = Alumni({passingYear: 2021, name: "Alice", location: "USA", catoegory: "Gold"});

        alumniAssociation.mint(alumni, data);

        assertEq(alumniAssociation.totalSupply(), 1);
        assertEq(alumniAssociation.ownerOf(1), alumni);

        (uint256 passingYear, string memory name, string memory location, string memory catoegory) =
            alumniAssociation.alumniData(1);
        assertEq(passingYear, 2021);
        assertEq(name, "Alice");
        assertEq(location, "USA");
        assertEq(catoegory, "Gold");

        assertEq(alumniAssociation.pointsOf(1), 0);
    }

    function test_multiMintFail() public {
        Alumni memory data1 = Alumni({passingYear: 2021, name: "Alice", location: "USA", catoegory: "Gold"});
        Alumni memory data2 = Alumni({passingYear: 2021, name: "Bob", location: "UK", catoegory: "Silver"});

        alumniAssociation.mint(alumni, data1);
        vm.expectRevert(bytes("Alumni can have only one token"));
        alumniAssociation.mint(alumni, data2);
    }
}
