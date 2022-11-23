import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

contract VolcanoCoin is ERC20 {
    constructor(uint256 initialSupply) ERC20("VolcanoCoin", "VOL") {
        _mint(msg.sender, initialSupply);
    }
}