// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../src/ShameToken.sol";

contract Shametest is Test {
    shameToken token;
    address admin = address(1);
    address shameooor = address(2); 
    address Alice = address(3);


    function setUp() public {
        vm.startPrank(admin);
        token = new shameToken();
        token.transfer(shameooor, 1);
        vm.stopPrank();
    }

    //transfer tests
    function testAdminTranfer1() public {
        vm.prank(admin);
        token.transfer(shameooor, 1);
        assertEq(token.balanceOf(shameooor), 2);
    }

    function testCannotTranfer2() public {
        vm.startPrank(admin);
        vm.expectRevert(bytes("Amount must be 1"));
        token.transfer(shameooor, 2);
        assertEq(token.balanceOf(shameooor), 1);
        vm.stopPrank();
    }
   
    function testShameTranfer(uint256 amount) public { //Fuzz test: any tranfer amount leads to shameoors balance + 1
        vm.startPrank(shameooor);
        token.transfer(admin, amount);
        assertEq(token.balanceOf(shameooor), 2);
        assertEq(token.balanceOf(admin), 0);
        vm.stopPrank();
    }

    //Approve tests
    function testApproveAdmin1() public {
        vm.startPrank(shameooor);
        token.approve(admin, 1);
        assertEq(token.allowance(shameooor, admin), 1);
        vm.stopPrank();
    }

    function testCannotApproveAdmin2() public {
        vm.startPrank(shameooor);
        vm.expectRevert(bytes("Amount must be 1"));
        token.approve(admin, 2);
        assertEq(token.allowance(shameooor, admin), 0);
        vm.stopPrank();
    }
    
    function testApproveOnlyAdmin() public {
        vm.startPrank(shameooor);
        vm.expectRevert(bytes("Spender must be admin"));
        token.approve(Alice, 1);
        assertEq(token.allowance(shameooor, Alice), 0);
        vm.stopPrank();
    }

    //Test transfer from
    function testTransferFromBurn1() public {
        vm.prank(shameooor);
        token.approve(admin, 1);
        vm.startPrank(admin);
        token.transferFrom(shameooor, admin, 1);
        assertEq(token.balanceOf(shameooor), 0);
        assertEq(token.balanceOf(admin), 0);
        vm.stopPrank();
    }

    function testOnlyAdminCanTranferFrom() public {
        vm.startPrank(Alice);
        vm.expectRevert(bytes("ERC20: insufficient allowance"));
        token.transferFrom(shameooor, admin, 1);
        assertEq(token.balanceOf(shameooor), 1);
        assertEq(token.balanceOf(admin), 0);
        vm.stopPrank();
    }

    
}
