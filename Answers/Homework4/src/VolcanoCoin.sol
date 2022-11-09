// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

contract VolcanoCoin {

    struct Payment {
        uint256 amount;
        address to;
    }

    // Public creates getter fn automatically
    uint256 public totalSupply = 1000;
    address owner;
    mapping(address => uint256) public balances;
    mapping(address => Payment[]) public payments;
    
    event totalSupplyIncreased(uint256);
    event transferEvent(uint256, address); 

    constructor() {
        owner = msg.sender;
        balances[owner] = totalSupply;     
    }

    modifier onlyOwner() {
        require(msg.sender == owner, 'Must be owner');
        // Underscore is a special character only used inside
        // a function modifier and it tells Solidity to
        // execute the rest of the code.
        _; 
    }
    
    function increaseSupply() public onlyOwner {
        totalSupply += 1000;
        emit totalSupplyIncreased(totalSupply);
    }

    function transfer(uint256 amount, address to) public {
        assert(balances[msg.sender] >= amount);
        balances[msg.sender] -= amount;
        balances[to] += amount;
        payments[msg.sender].push(Payment(amount, to));
        emit transferEvent(amount, to);
    }

}