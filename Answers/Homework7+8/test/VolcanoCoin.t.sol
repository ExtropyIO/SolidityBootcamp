// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../src/VolcanoCoin.sol";

contract VolcanoCoinTest is Test {
    VolcanoCoin public vc;
    address deployer = address(1);
    address alice = address(2);
    address bob = address(3);
    uint256 totalSupply = 1000;
    uint256 public i;
    address public a;

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

    // Test payment array updates
    function testPaymentStruct() public {
        vm.prank(deployer);
        vc.transfer(10, alice);
        VolcanoCoin.Payment[] memory arr = vc.getPayments(deployer);
        assertEq(arr[0].amount, 10);
        assertEq(arr[0].to, alice);
    }

    function testPublicMapiingGetter() public {
        vm.prank(deployer);
        vc.transfer(10, alice);
        (i, a) = vc.payments(deployer, 0);
    }
}