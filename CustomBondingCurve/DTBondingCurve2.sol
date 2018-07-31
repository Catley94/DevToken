pragma solidity ^0.4.24;



/**
         * @title SafeMath
         * @dev Math operations with safety checks that throw on error
         */
        library SafeMath {

          /**
          * @dev Multiplies two numbers, throws on overflow.
          */
          function mul(uint256 a, uint256 b) internal pure returns (uint256) {
            if (a == 0) {
              return 0;
            }
            uint256 c = a * b;
            assert(c / a == b);
            return c;
          }

          /**
          * @dev Integer division of two numbers, truncating the quotient.
          */
          function div(uint256 a, uint256 b) internal pure returns (uint256) {
            // assert(b > 0); // Solidity automatically throws when dividing by 0
            uint256 c = a / b;
            // assert(a == b * c + a % b); // There is no case in which this doesn't hold
            return c;
          }

          /**
          * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
          */
          function sub(uint256 a, uint256 b) internal pure returns (uint256) {
            assert(b <= a);
            return a - b;
          }

          /**
          * @dev Adds two numbers, throws on overflow.
          */
          function add(uint256 a, uint256 b) internal pure returns (uint256) {
            uint256 c = a + b;
            assert(c >= a);
            return c;
          }
        }

contract DevToken {
	using SafeMath for uint;
	using SafeMath for uint8;
	using SafeMath for uint16;
	using SafeMath for uint32;


//VARIABLES
	string public name;
	string public symbol;
	uint8 public decimals = 0;
	uint public totalSupply;
	uint public poolBalance;
	uint public currentBuyPrice;
	uint public currentSellPrice;
	uint public constant basePrice = 1000000000000; //0.00001 ETH
	uint private buyCounter;
	uint private sellCounter;
	uint private lastBuyPrice;

    uint128 private counter;
//MAPPINGS
mapping (address => uint) ethBalance;
mapping (address => uint) tokenBalance;
mapping (uint => address) allAddresses;


//MODIFIERS
modifier noEmptyMsgValue() {
	//require msg.value to be greater than 0 || msg.value cannot be 0
	assert(msg.value != 0);
	_;
}
/*
modifier pbtsEqualZero() {
    while(totalSupply == 0 && poolBalance == 0 ){
			currentBuyPrice = basePrice;
			break;
		}
}
*/
/*
modifier noEmptyAmountOfTokens() {
	// require _amountOfTokens cannot be 0
	assert(_amountOfTokens != 0);
	_;
}
*/


//CONSTRUCTOR
	constructor(string _name, string _symbol) public {
	name = _name;
	symbol = _symbol;


	}












//FUNCTIONS

function showMyBalance() public view returns (uint) {
    return tokenBalance[msg.sender];
}
/*
function showAllAddresses() public view returns (address) {
    uint i = 0;
    while( i <= counter) {
        return allAddresses[i];
        i++;


}
}
*/

function _calculatorBuyPrice(uint _tokenAmount) private view returns (uint _currentBuyPrice) {
    for(uint8 i=0; i<1; i++){
    if(poolBalance != 0 && totalSupply != 0){
    //_totalSupply has the same value as totalSupply
    uint _totalSupply = totalSupply;
    //_poolBalance has the same value as poolBalance
    uint _poolBalance = poolBalance;
    //temp stores the answer of _totalSupply + _amountOfTokens
    uint temp = _totalSupply.add(_tokenAmount);
    //diffValue stores the answer of _poolBalance / temp
    uint diffValue = _poolBalance.div(temp);
    uint timesBy = (diffValue * 25)/1000;
    //_currentBuyPrice stores the answer of diffValue + lastBuyPrice
    _currentBuyPrice = timesBy.add(lastBuyPrice);
    //require the answer of _amountOfTokens divided by _currentBuyPrice to equal 0 (as this token will not have decimals)
    //require(_amountOfTokens % _currentBuyPrice == 0);
    } else {
        _currentBuyPrice = basePrice;
    }
    break;
    }


}

function _calculatorTotalBuyPrice(uint _tokenAmount) public view returns (uint _totalPrice) {
    uint _currentBuyPrice = _calculatorBuyPrice(_tokenAmount);
    _totalPrice = _tokenAmount * _currentBuyPrice;
}




//CHECK THROUGH CODE, FIRST BUY WORKS, CHECK IT CARRIES ON WORKING




function _testBuy(uint _amountOfTokensBought) public payable noEmptyMsgValue returns (bool){
    require(_amountOfTokensBought != 0, "You must buy at least 1 token.");
    if(totalSupply != 0 && poolBalance != 0 ){
			currentBuyPrice = _calculatorBuyPrice(_amountOfTokensBought);
		} else {
        currentBuyPrice = basePrice;
		}

    uint _totalPrice = _amountOfTokensBought * currentBuyPrice; // _totalPrice chargable to purchaser

     //require(_totalPrice % currentBuyPrice == 0);

     if(msg.value % _totalPrice != 0) {
        revert();
     } else {
    poolBalance = poolBalance.add(msg.value);
    ethBalance[this] = poolBalance;
    totalSupply = totalSupply.add(_amountOfTokensBought);
	tokenBalance[msg.sender] = tokenBalance[msg.sender].add(_amountOfTokensBought);
	//not working for array
	allAddresses[counter] = msg.sender;
	counter++;
	buyCounter++;
	lastBuyPrice = currentBuyPrice;
	return true;
     }
}







function _calculatorSellPrice(uint _amountOfTokens) private view returns (uint _currentSellPrice) {
    for(uint8 i=0; i<1; i++){
        require(poolBalance != 0 && totalSupply != 0, "Contract Balance and Total Supply are empty.");
        if(buyCounter > 1){
    //_totalSupply has the same value as totalSupply
    uint _totalSupply = totalSupply;
    //_poolBalance has the same value as poolBalance
    uint _poolBalance = poolBalance;
    //temp stores the answer of _totalSupply + _amountOfTokens
    uint temp = _totalSupply.sub(_amountOfTokens);
    //diffValue stores the answer of _poolBalance / temp
    uint diffValue = _poolBalance.div(temp);
		uint timesBy = (diffValue * 13)/1000;
    //_currentBuyPrice stores the answer of diffValue + lastBuyPrice
    _currentSellPrice = lastBuyPrice.sub(timesBy);
        } else if (buyCounter == 1) {
            _currentSellPrice = (basePrice * 13)/1000;
        } else {
            revert("Unable to sell due to no one has bought any tokens.");
        }
        break;
    }



}






function _calculatorTotalSellPrice(uint _tokenAmount) public view returns (uint _totalPrice) {
    uint _currentSellPrice = _calculatorSellPrice(_tokenAmount);
    _totalPrice = _tokenAmount * _currentSellPrice;
}
// change below function to bool ? add if statement

function showContractBalance() public view returns (uint) {
    return ethBalance[this];
}



function _testSell(uint _amountOfTokensSold) public returns (bool) {
    require(_amountOfTokensSold != 0, "This needs to be greater than 0.");
    require(poolBalance != 0 && totalSupply != 0, "You cannot sell as the Contract Balance and Total Supply are empty.");
	if(tokenBalance[msg.sender] != 0) {
			//Updates currentBuyPrice value by calling _calculatorBuyPrice
	    currentSellPrice = _calculatorSellPrice(_amountOfTokensSold);
	    assert(currentSellPrice != 0);
	    uint _totalSellPrice = currentSellPrice.mul(_amountOfTokensSold);
        assert(_totalSellPrice != 0);
	    require(_totalSellPrice < ethBalance[this], "Total amount of Ether must be less than the amount in the contract balance.");
	    poolBalance = poolBalance.sub(_totalSellPrice);
	    ethBalance[this] = poolBalance;
	    totalSupply = totalSupply.sub(_amountOfTokensSold);
		tokenBalance[msg.sender] = tokenBalance[msg.sender].sub(_amountOfTokensSold);
		msg.sender.transfer(_totalSellPrice);
		sellCounter++;
		return true;
		} else {
			revert("You have no tokens to sell.");
		}

	//use transfer from smart contract (eth) to sender (eth)
	//send eth back to msg.sender


}




}
