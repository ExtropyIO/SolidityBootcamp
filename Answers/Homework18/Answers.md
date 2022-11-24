# Homework 18

1. See if you can listen to the mempool using ether.js (or similar web3.py etc)
```js 
const ethers = require("ethers");
const url = "ADD_YOUR_ETHEREUM_NODE_WSS_URL";

async function main () {
  var customWsProvider = new ethers.providers.WebSocketProvider(url);
  
  customWsProvider.on("pending", (tx) => {
    customWsProvider.getTransaction(tx).then(function (transaction) {
      console.log(transaction);
    });
  });

};

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

```

2. Can you ﬁnd a way to filter your mempool listener and get only uniswap transactions?
```
Many ways to so this. Here we listen to Swap events on the USDC USDT swap pool contract.
```

```js 
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
```

3. How might  you mitigate MEV & front running if you were building your own Dapp?

```md
## Projects trying to reduce the MEV used

### Mistx

launched by Alchemist using Flashbots technology
Features
- no Gas fees for transactions  (bribes are paid to miners in tokens)
- MEV-proof

### Archer Swap

Uses Archer Relay which works with miners to find the most valuable trades for them and allows them to submit them to the ethereum mainnet.


### Secret Swap

SecretSwap is a cross chain AMM built on Cosmos and Tendermint
It has an encrypted Mempool 
Users will have to pay for gas and 0.3% swap fees with the $SCRT token to use Secret Swap.
![](https://i.imgur.com/ymGcIti.png)

### Cow Swap
CowSwap is a DEX and DEX aggregator hybrid backed by Gnosis Protocol V2 (GPv2) which is developed by Gnosis team in order to provide MEV protection. GPv2 optimizes for coincidence of wants (CoWs), which can be explained as “an economic phenomenon where two parties each hold an item the other wants, so they exchange these items directly.”, i.e. peer-to-peer transactions can be matched without having to go through a regular AMMs like Uniswap or Sushiswap. One of the benefits of this is that off-chain transactions will cost a lot less and be faster.

CowSwap brings in ‘Solver’ conception to realize this function. Solvers are encouraged to compete against each other to deliver the best order settlement for traders in exchange for the reward of each batch. CowSwap will use a united price to settle all orders in the same batch, which is called batch auction mechanism. This process is very similar to Ethereum meta-transactions proposed in 2018.
```


4. Have a look at the example sandwich bot and see how it works [Repo](https://github.com/libevm/subway). 

