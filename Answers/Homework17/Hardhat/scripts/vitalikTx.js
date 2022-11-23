// run $ npx hardhat run scripts/vitalikTx.js 

const { ethers} = require("hardhat");

async function main() {

    const currentBlock = await ethers.provider.getBlock("latest")
    console.log("Current block number: ", currentBlock.number); 

    const vitalik = await ethers.getImpersonatedSigner("0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045");
  
    const receiver = await ethers.getImpersonatedSigner("0xDAFEA492D9c6733ae3d56b7Ed1ADB60692c98Bc5");
    console.log("Receiver balance before transfer: ", await receiver.getBalance());

    const transfer = await vitalik.sendTransaction({
      to: receiver.address,
      value: ethers.utils.parseEther("10"),
    });

    console.log("Receiver balance after transfer: ", await receiver.getBalance());

}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
