// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

/*
       REQUIREMENTS
    1. Your contract will have public variables that store the details about your coin (Token Name, Token Abbrv., Total Supply)
    2. Your contract will have a mapping of addresses to balances (address => uint)
    3. You will have a mint function that takes two parameters: an address and a value. 
       The function then increases the total supply by that number and increases the balance 
       of the “sender” address by that amount
    4. Your contract will have a burn function, which works the opposite of the mint function, as it will destroy tokens. 
       It will take an address and value just like the mint functions. It will then deduct the value from the total supply 
       and from the balance of the “sender”.
    5. Lastly, your burn function should have conditionals to make sure the balance of "sender" is greater than or equal 
       to the amount that is supposed to be burned.
*/

contract MyToken {
  // Public variables for token details
  string public name;
  string public symbol;
  uint256 public totalSupply;

  // Mapping for address to token balances
  mapping(address => uint256) public balances;

  // Event to log token transfer
  event Transfer(address indexed from, address indexed to, uint256 value);

  // Constructor to initialize token details
  constructor(string memory _name, string memory _symbol, uint256 _initialSupply) {
    name = _name;
    symbol = _symbol;
    totalSupply = _initialSupply;
    balances[msg.sender] = totalSupply; // Allocate initial supply to deployer
  }

  // Function to mint new tokens
  function mint(address recipient, uint256 value) public {
    totalSupply += value;
    balances[recipient] += value;
    emit Transfer(address(0), recipient, value); // Log mint event
  }

  // Function to burn tokens
  function burn(uint256 value) public {
    require(balances[msg.sender] >= value, "Insufficient balance for burn");
    totalSupply -= value;
    balances[msg.sender] -= value;
    emit Transfer(msg.sender, address(0), value); // Log burn event
  }
}
