// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

struct Alumni {
    uint256 passingYear;
    string name;
    string location;
    string catoegory;
}

contract AlumniAssociation is ERC721 {
    // admin address
    address public admin;

    // total supply of tokens
    uint256 public totalSupply;

    // tokenID to Alumni mapping
    mapping(uint256 => Alumni) public alumniData;
    mapping(uint256 => uint256) alumniPoints;
    mapping(string => uint256) points;

    constructor() ERC721("AlumniAssociation", "AA") {
        admin = msg.sender;
        points["Conference Paper"] = 10;
        points["Journal Paper"] = 15;
        points["Technical Blog"] = 1;
    }

    /**
     * @dev Mint a new token
     * @param to address to mint the token to
     */
    function mint(address to, Alumni memory data) public {
        require(msg.sender == admin, "only admin can mint");
        require(balanceOf(to) == 0, "Alumni can have only one token");
        totalSupply++;
        _mint(to, totalSupply);
        alumniData[totalSupply] = data;
    }

    function gradePoints(uint256 tokenID, string memory assignment) public {
        require(msg.sender == admin, "only admin can grade points");
        require(points[assignment] > 0, "Invalid assignment");

        alumniPoints[tokenID] += points[assignment];
    }

    function pointsOf(uint256 tokenID) public view returns (uint256) {
        return alumniPoints[tokenID];
    }
}
