require("@nomicfoundation/hardhat-toolbox");
require('hardhat-docgen');

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  docgen: {
    path: './docs',
    clear: true,
    runOnCompile: true,
  }
};
