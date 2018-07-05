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
    //Public definition for depositAmount - equal to 1 ether (testing purposes only, set to DevTokens in future)
    //Commented out below, testing between public definition or requirement
    //uint public depositAmount = 1 * ether;

    //Requirement of 1 ether for depositAmount
    modifier depositAmount {
      require(depositAmount = 1 * ether);
    }

    //Check that the deposit of the candidate/listee meets the deposit requirement
    modifier depositReq {
      require(_checkDeposit == true);

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
    //Defining the check for the deposit has been reached.
    function _checkDeposit (uint _depositAmount) private {
      depositAmount = _depositAmount;
      if msg.sender[msg.value] == _depositAmount {
        return true
      }
        // write else statement here
      }

    }


    function posOnLeaderboard (uint8 position, uint numOfVotes) internal depositReq() {


    }










}
