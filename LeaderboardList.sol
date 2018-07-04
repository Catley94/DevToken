pragma solidity ^0.4.24;

import "./SafeMath.sol";

contract LeaderboardList {

    using SafeMath for uint8, uint256;
    //Public definition for leaderBoardPos (Position)
    uint8 public leaderboardPos;

    //Struct for the Leaderboard, listing variables below
    struct Leaderboard {
      uint8 totalDevList;


    }
    //Struct for the developer, listing variables below
    //TODO "numOfChallenges", is it needed?
    struct Developer {
      uint8 position;
      uint numOfVotes;
      uint numOfChallenges;
      bool deposit;
                  


    }










}
