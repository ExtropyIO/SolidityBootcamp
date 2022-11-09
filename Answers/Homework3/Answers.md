# Homework 3

To this [contract](https://gist.github.com/extropyCoder/77487267da199320fb9c852cfde70fb1) 
1. Add a variable to hold the address of the deployer of the contract
```js
address deployer;
```


2. Update that variable with the deployer's address when the contract is deployed.
```js
constructor() {
    deployer = msg.sender;
}
```
3. Write an external function to return
	1. Address `0x000000000000000000000000000000000000dEaD` if called by the deployer
	2. The deployer's address otherwise
```js
function onlyDeployer() public view returns (address){
    if (msg.sender == deployer) {
        return returnVal;
    } else {
        return msg.sender;
    }
}
```