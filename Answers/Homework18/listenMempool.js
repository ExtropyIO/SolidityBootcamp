const ethers = require("ethers");
const url = "[YOUR-RPC-URL]";

async function  main() {
  const customWsProvider = await new ethers.providers.WebSocketProvider(url);
  
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