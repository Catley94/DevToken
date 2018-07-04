pragma solidity ^0.4.24;

import "./BondingCurve.sol";
import "./Leaderboard.sol";



contract DevToken is BondingCurve, Leaderboard {



  // solium-disable-next-line uppercase
  string public constant name = "Developer Token";
  string public constant symbol = "DEV"; // solium-disable-line uppercase
  uint8 public constant decimals = 18; // solium-disable-line uppercase

}






