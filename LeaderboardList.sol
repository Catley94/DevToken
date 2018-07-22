pragma solidity ^0.4.24;

import "./SafeMath.sol";
import "./DevToken.sol";

/**
TODO:
Define how to meet the requirement of the deposit in depositReq
Define each vote using DevToken (+1 per address), DECISION:
  -Each developers voting pool has a different smart contract(or normal?) address
   list all the addresses and list by weight, decending style.
  -Put all votes in poolBalance and link votes to each developer to list by weight.

Define the position on the leaderboard by weight (as mentioned above).


*/

contract DevToken {



  // solium-disable-next-line uppercase
  constructor() public {
  string public name = "Developer Voting Token";
  string public symbol = "DVT"; // solium-disable-line uppercase
  uint8 public decimals = 18; // solium-disable-line uppercase
  uint public totalSupply = 0; //Start amount of tokens, 0 as we will be minting and burning tokens.

    }
}


contract LeaderboardList is BondingCurve {

/*
  constructor(uint256 _rate, address _wallet, ERC20 _token, address _beneficiary, address from) public {
  require(_rate > 0);
  //replace _wallet with msg.sender == 0; ?
  //require(_wallet != address(0));
  require(_token != address(0));
  rate = _rate; // replace with static rate of token, base price.
  token = _token; // replace _token with token smart contract address.
}
*/
    uint public rate;
    ERC20 public token;
    using SafeMath for uint8;
    using SafeMath for uint256;

    event LogMint(tokensToMint, msg.value);

    //Public definition for depositAmount - equal to 1 ether (testing purposes only, set to DevTokens in future)
    //Commented out below, testing between public definition or requirement
    //uint public depositAmount = 100 * DVT;

    //Requirement of 100 DVT for depositAmount
    modifier depositAmount(uint _value) {
      //link rate to BondingCurve and BancorFormula
      //TODO: edit below for rate.
      _value = rate * 100 DVT;
      require(_value == 100 DVT);
      _;
    }
    uint minDepositAmount = 100 DVT;
    bool checkDeposit = false;
    //Check that the deposit of the candidate/listee meets the deposit requirement
    modifier paidDeposit {
      require(checkDeposit == true);
      _;

    }
    mapping(uint => address) idToOwner;

    event devCreated(name, position, depositPaid);

    uint16 totalNumOfDevs = developers.length;
s
    //Struct for the developer, listing variables below
    //TODO "numOfChallenges", is it needed?
    struct Developer {
      address public myAddress;
      string public name;
      uint8 public position;
      uint public numOfVotes;
      uint public numOfChallenges;
      bool internal depositPaid;
    }
     //Public definition for leaderBoardPos (Position)
     Developer[] public developers;

//create function for both dev deposit and user deposit, currently the below covers all deposits but not ideal.
        function registerDev(address _myAddress, string _name, bool _checkDeposit, uint _totalNumOfDevs) public payable depositAmount {
      require(checkDeposit == false);
      // calculate token amount to be created
      uint256 tokens = _getTokenAmount(weiAmount);

      buy();
      if (msg.value >= depositAmount) {
        checkDeposit = _checkDeposit = true;
        uint id = developers.push(Developer(
          _myAddress,
          _name,
          //position - link to function finding the Position
          0,
          0,
          _checkDeposit)) -1;
          idToOwner[id] = msg.sender;
          totalNumOfDevs = _totalNumOfDevs++;
          //add position to event
          posOnLeaderboard(id, _numOfVotes)

          emit devCreated(_myaddress, _name, _position, 0, 0, _depositPaid );
          return id;
      } else {
        checkDeposit = _checkDeposit = false;
        //revert? Error throw

      }
      checkDeposit = false;

      //uint id =
      }


      function _getTokenAmount(uint256 _weiAmount)
    internal view returns (uint256)
  {
    return _weiAmount.mul(rate);
  }

    function getAllDevInfo () internal view {

    }

    //Correct/edit function below
    //Load developer in memory, reference the memory for the function below
    // storage or memory?
    function posOnLeaderboard (uint id uint _numOfVotes) internal view returns (uint _position) {
      Developer storage selectedDev = developers[id];
      _numOfVotes = selectedDev.numOfVotes;
      if(require(_numOfVotes >= 0)) {

      }

      }

    }


}
/*
contract MintableToken is StandardToken, Ownable {
  event Mint(address indexed to, uint256 amount);
  event MintFinished();

  bool public mintingFinished = false;


  modifier canMint() {
    require(!mintingFinished);
    _;
  }

  modifier hasMintPermission() {
    require(msg.sender == owner);
    _;
  }


   * @dev Function to mint tokens
   * @param _to The address that will receive the minted tokens.
   * @param _amount The amount of tokens to mint.
   * @return A boolean that indicates if the operation was successful.

  function mint (
    address _to,
    uint256 _amount
  )
    hasMintPermission
    canMint
    internal
    returns (bool)
  {
    totalSupply_ = totalSupply_.add(_amount);
    balance[_to] = balance[_to].add(_amount);
    emit Mint(_to, _amount);
    emit Transfer(address(0), _to, _amount);
    return true;
  }


   * @dev Function to stop minting new tokens.
   * @return True if the operation was successful.

  function finishMinting() onlyOwner canMint public returns (bool) {
    mintingFinished = true;
    emit MintFinished();
    return true;
  }
}
*/
