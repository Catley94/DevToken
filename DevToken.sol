pragma solidity ^0.4.24;



import "./proxy.sol";


contract DevToken is Proxy {

  string public name;
  string public symbol;
  uint8 public decimals = 18;
  uint public totalSupply;

  // solium-disable-next-line uppercase
  constructor(
    uint initialSupply,
    string tokenName,
    string tokenSymbol
    ) public {
    totalSupply = initialSupply * 10 ** uint256(decimals);
    balanceOf[msg.sender] = totalSupply;
    name = tokenName;
    symbol = tokenSymbol;
    string public tokenName = "Developer Voting Token";
    string public tokenSymbol = "DVT"; // solium-disable-line uppercase
    uint public totalSupply = 1; //Start amount of tokens, 0 as we will be minting and burning tokens.

    }
}
