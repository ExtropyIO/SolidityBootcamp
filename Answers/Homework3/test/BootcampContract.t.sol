// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../src/BootcampContract.sol";


contract BootcampContractTest is Test {

    BootcampContract public testContract;
    address public returnVal; 

    //setup: deploys contract / sets varibles for tests
    function setUp() public {
        testContract = new BootcampContract();
        returnVal = 0x000000000000000000000000000000000000dEaD;
    }

    // tests returns returnVal if mes.sender == contract owner
    function testDeployerOnly() public {
        assertEq(testContract.onlyDeployer(), returnVal);
    }

    // test returns msg.sender if mes.sender != contract owner
    function testNotDeployer() public {
        vm.prank(address(1));
        assertEq(testContract.onlyDeployer(), address(1));
    }
}
