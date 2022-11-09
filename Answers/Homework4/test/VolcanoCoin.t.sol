// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../src/VolcanoCoin.sol";

contract VolcanoCoinTest is Test {
    VolcanoCoin public vc;
    address deployer = address(0);
    address alice = address(1);
    address bob = address(2);
    uint256 totalSupply = 1000;

    //deploy contract
    function setUp() public {
        vm.prank(deployer);
        vc = new VolcanoCoin();
    }

    // init totalySupply == 1000
    function testInitTotalSupply() public {
        assertEq(vc.totalSupply(), totalSupply);
    }

    // Owner can increase totalySuppply
    function testIncreaseSupply() public {
        vm.prank(deployer);
        vc.increaseSupply();
        assertEq(vc.totalSupply(), 2000);
    }

    // Must be owner to inrease supply
    function testOnlyOwner() public {
        vm.prank(alice);
        vm.expectRevert(bytes("Must be owner"));
        vc.increaseSupply();
        assertEq(vc.totalSupply(), 1000);
    }

    // test transfer works
    function testTransfer() public {
        vm.prank(deployer);
        vc.transfer(1, alice);
        assertEq(vc.balances(alice), 1);
        vm.prank(alice);
        vc.transfer(1, bob);
        console.log(vc.balances(bob));
        assertEq(vc.balances(bob), 1);
    }

}