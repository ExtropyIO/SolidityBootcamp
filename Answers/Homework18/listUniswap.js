const Web3 = require('web3');
const abi = require('./abi.json');

//Contract & Web3
const web3 = new Web3('{YOUR-RPC_WEBSOCKET}'); // Be sure to use a websocket NOT rest:
const UniSwap = new web3.eth.Contract(abi, '0x7858E59e0C01EA06Df3aF3D20aC7B0003275D4Bf');


//https://etherscan.io/address/0x7858e59e0c01ea06df3af3d20ac7b0003275d4bf#events
//Here we listen for Swap events on USDT USDC pool
async function  main() {
  UniSwap.events.Swap().on("data", (event => {
    console.log(event);
  })).on("error", console.error); 
}
  
main();