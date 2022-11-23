// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../src/VolcanoNFT.sol";
import "../src/VolcanoCoin.sol";

contract VolcanoNFTTest is Test {
    using stdStorage for StdStorage;

    VolcanoNFT public nft;
    VolcanoCoin public token;
    address alice = address(1);
    address bob = address(2);
    uint256 tokenId;


    function setUp() public {
        vm.startPrank(alice);
        token = new VolcanoCoin(1000);
        nft = new VolcanoNFT(address(token));
        vm.stopPrank();
        
    }

    function writeTokenBalance(address who, address token, uint256 amt) internal {
        stdstore
            .target(token)
            .sig(IERC20(token).balanceOf.selector)
            .with_key(who)
            .checked_write(amt);
    }

    function testMint() public {
        vm.startPrank(alice);
        //Can alice mint herself a token?
        tokenId = nft.mintNFT(alice);
        assertEq(tokenId, 1);
        assertEq(nft.ownerOf(1), alice);
        assertEq(nft.balanceOf(alice), 1);
        // Can Alice mint a token for bob?
        tokenId = nft.mintNFT(bob);
        assertEq(tokenId, 2);
        assertEq(nft.ownerOf(2), bob);
        assertEq(nft.ownerOf(1), alice);
        assertEq(nft.balanceOf(alice), 1);
        assertEq(nft.balanceOf(bob), 1);
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

    function testETHMint() public {
        vm.startPrank(bob);
        vm.deal(bob, 1 ether);
        tokenId = nft.EthMint{value: 1 ether}();
        assertEq(nft.ownerOf(tokenId), bob);
    }

    function testERC20Mint() public {
        vm.startPrank(bob);
        writeTokenBalance(bob, address(token), 100);
        token.approve(address(nft), 1);
        tokenId = nft.ERC20Mint(1);
        assertEq(nft.ownerOf(tokenId), bob);
    }
}