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
    // Public variables
    string public tokenName;
    string public tokenAbbrv;
    uint public totalSupply;

    // Mapping of addresses to balances
    mapping(address => uint) public balances;

    // Constructor to initialize public variables
    constructor(string memory _tokenName, string memory _tokenAbbrv, uint _initialSupply) {
        tokenName = _tokenName;
        tokenAbbrv = _tokenAbbrv;
        totalSupply = _initialSupply;
        balances[msg.sender] = _initialSupply;
    }

    // Mint function
    function mint(address _to, uint _value) public {
        totalSupply += _value;
        balances[_to] += _value;
    }

    // Burn function
    function burn(address _from, uint _value) public {
        require(balances[_from] >= _value, "Insufficient balance to burn");
        require(totalSupply >= _value, "Insufficient total supply to burn");

        totalSupply -= _value;
        balances[_from] -= _value;
    }
}
