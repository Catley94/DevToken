pragma solidity ^0.4.24;

import "./SafeMath.sol";

/**
TODO:
Define how to meet the requirement of the deposit in depositReq
Define each vote using DevToken (+1 per address), DECISION:
  -Each developers voting pool has a different smart contract(or normal?) address
   list all the addresses and list by weight, decending style.
  -Put all votes in poolBalance and link votes to each developer to list by weight.

Define the position on the leaderboard by weight (as mentioned above).


*/
contract LeaderboardList {

    using SafeMath for uint8, uint256;
    //Public definition for leaderBoardPos (Position)
    uint8 public leaderboardPos;

    //Check that the deposit of the candidate/listee meets the deposit requirement
    modifier depositReq {
      require(Developer[deposit] == true);

    }


    //Struct for the developer, listing variables below
    //TODO "numOfChallenges", is it needed?
    struct Developer {
      uint8 position;
      uint numOfVotes;
      uint numOfChallenges;
      bool deposit;




    }
    //Struct for the Leaderboard, listing variables below
    struct Leaderboard {
      uint8 totalDevList;
      mapping (uint => Developer) developers;

    }
    //Defining each
    function


    function posOnLeaderboard (uint8 position, uint numOfVotes) internal depositReq() {


    }










}
