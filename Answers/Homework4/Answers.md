# Homework 4 - Answers



## VolcanoCoin contract 


At each point where you change your contract you should re deploy to the JavascriptVM and test your changes.


1. In Remix, create a new file called `VolcanoCoin.sol`.

2. Define the pragma compiler version to `0.8.17`. 

```js
pragma solidity 0.8.17;
```
3. Before the pragma version, add a license identifer 
	`// SPDX-License-Identifier: UNLICENSED`.

```js
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;
```

4. Create a contract called VolcanoCoin.

```js
...
contract VolcanoCoin {

}
```

5. Create a variable to hold the total supply of 10000. 
```js
uint256 totalSupply = 1000;
```


6. Make a public function that returns the total supply. 
```js
//by adding public solidity will create a getter fn. 
uint256 public totalSupply = 1000;
```

7. Make a public function that can increase the total supply. Inside the function, add 1000  to the current total supply.
```js
function increaseSupply() public {
    totalSupply += 1000;
    emit totalSupplyIncreased(totalSupply);
}
```

8. We probably want users to be aware of functions in the contract for greater transparency, but to make them all public will create some security risks (e.g. we don't want users to be able to change the total supply). 

    Declare an `address` variable called `owner`.

```js
address owner;
```

9. Next, create a `modifier`  which only allows an owner to execute certain functions. 

```js
modifier onlyOwner() {
    require(msg.sender == owner, 'Must be owner');
    _; 
}
```

10. Make your change total supply function `public`, but add your modifier so that only the owner can execute it.

```js
function increaseSupply() public onlyOwner {
    totalSupply += 1000;
}
```
 
11. The contract owner's address should only be updateable in one place. Create a constructor and within the constructor, store the owner's address. 

```js
constructor() {
    owner = msg.sender;
}
```

12. It would be useful to broadcast a change in the total supply. Create an event that emits the new value whenever the total supply changes. When the supply changes, emit this event. 

```js
event totalSupplyIncreased(uint256);
...
function increaseSupply() public onlyOwner {
    ...
    emit totalSupplyIncreased(totalSupply);
}
```

13. In order to keep track of user balances, we need to associate a user's address with the balance that they have.
    a) What is the best data structure to hold this association ?
```js
A mapping
```
b) Using your choice of data structure, set up a variable called `balances` to keep track of the number of volcano coins that a user has.
```js
mapping(address => uint) balances;
```
    
14. We want to allow the balances variable to be read from the contract, there are 2 ways to do this.
     What are those ways ?
```js
//Add public to the mapping 
mapping(address => uint) public balances;

//or write a function 
function getBalances(address index) public view returns (uint256) {
    return balances[index];
}
```
Use one of the ways to make your balances variable visible to users of the contract.


15. Now change the constructor, to give all of the total supply to the owner of the contract.
```js
constructor() {
    owner = msg.sender;
    balances[owner] = totalSupply;        
}
```

16. Now add a public function called transfer to allow a user to transfer their tokens to another address. This function should have 2 parameters : 
	*    the amount to transfer and
	*    the recipient address.
```js
function transfer(uint256 amount, address to) public {
    assert(balances[msg.sender] >= amount);
    balances[msg.sender] -= amount;
    balances[to] += amount;
    payments[msg.sender].push(Payment(amount, to));
}
```

Why do we not need the sender's address here ? 
What would be the implication of having the sender's address as a parameter ?
```js
//We can get it using msg.sender. 
//If we had a sender address an attacker could transfer funds to themselves. 
```
    
17. Add an `event` to the transfer function to indicate that a transfer has taken place, it should log the amount and the recipient address.
```js
event transferEvent(uint256, address); 

...

function transfer(uint256 amount, address to) public {
...
    emit transferEvent(amount, to);
}
```
 
18. We want to keep a record for each user's transfers. Create a `struct` called Payment that stores the transfer amount and the recipient's address.
```js

struct Payment {
    uint256 amount;
    address to;
}
```

19. We want to have a payments array for each user sending the payment. Create a `mapping` which returns an array of Payment structs when given this user's address.
```js
mapping(address => Payment[]) public payments;
```

### Resources 


[Official Solidity Documentation](https://docs.soliditylang.org/en/latest/)
[Globally Available Variables](https://docs.soliditylang.org/en/v0.8.6/units-and-global-variables.html)
