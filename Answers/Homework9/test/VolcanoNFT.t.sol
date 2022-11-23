// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/VolcanoNFT.sol";

contract VolcanoNFTTest is Test {
    VolcanoNFT public nft;
    address alice = address(1);
    address bob = address(2);
    uint256 tokenId;

    function setUp() public {
        nft = new VolcanoNFT();
    }

    function testMint() public {
        vm.startPrank(alice);
        tokenId = nft.mintNFT(alice);
        assertEq(tokenId, 1);
        assertEq(nft.ownerOf(1), alice);
        assertEq(nft.balanceOf(alice), 1);

        tokenId = nft.mintNFT(bob);
        assertEq(tokenId, 2);
        assertEq(nft.ownerOf(2), bob);
        assertEq(nft.ownerOf(1), alice);
        assertEq(nft.balanceOf(alice), 1);
        assertEq(nft.balanceOf(bob), 1);
        vm.stopPrank();
    }

    function testTransfer() public {
        vm.startPrank(alice);
        tokenId = nft.mintNFT(alice);
        nft.transferFrom(alice, bob, tokenId);
        assertEq(nft.ownerOf(tokenId), bob);
        assertEq(nft.balanceOf(alice), 0);
        assertEq(nft.balanceOf(bob), 1);
        vm.stopPrank();
    }
}