# Homework 7

### Adding more functionality to the Volcano Coin contract

1.  We made a payment mapping, but we haven’t added all the functionality for it yet. 
	Write a function to view the payment records, specifying the user as an input.
	What is the difference between doing this and making the mapping public ?
```js
//If we set the mapping to public and call the default getter fn we will have to specify both the mapping key 
//and the array position. This will return a single a tuple of a single Payment struct/entry

//Writing our own function we can return the whole array for a given address. 

function getPayments(address index) public view returns (Payment[] memory) {
	Payment[] memory arr = payments[index];
	return arr;
}
```

2.  For the payments record mapping, create a function called `recordPayment` that takes 
	1. the sender’s address, 
	2. the receiver’s address and 
	3. the amount 
	as an input, then creates a new payment record and adds the new record to the user’s payment record. 
```js
function _recordPayment(address from, address to, uint256 amount) private {
    payments[from].push(Payment(amount, to));
}
```

	
3.  Each time we make a transfer of tokens, we should call the  this `recordPayment` function to record the transfer.

```js
function transfer(uint256 amount, address to) public {
...
    _recordPayment(msg.sender, to, amount);
...
```