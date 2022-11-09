// SPDX-License-Identifier: None

pragma solidity 0.8.17;


contract BootcampContract {

    uint256 number;
    address deployer;
    address returnVal = 0x000000000000000000000000000000000000dEaD;

    constructor() {
        deployer = msg.sender;
    }

    function store(uint256 num) public {
        number = num;
    }

    function retrieve() public view returns (uint256){
        return number;
    }

    function onlyDeployer() public view returns (address){
        if (msg.sender == deployer) {
            return returnVal;
        } else {
            return msg.sender;
        }
    }
}