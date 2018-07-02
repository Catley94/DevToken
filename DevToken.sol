pragma solidity ^0.4.24;

import "./MintableToken.sol";
import "./BurnableToken.sol";
import "./Crowdsale.sol";




contract DevToken is MintableToken, BurnableToken {

  

  // solium-disable-next-line uppercase
  string public constant name = "Developer Token";
  string public constant symbol = "DEV"; // solium-disable-line uppercase
  uint8 public constant decimals = 18; // solium-disable-line uppercase

}
  
  

contract LeaderboardCrowdsale is Crowdsale {
    
    constructor(
        uint256 _rate,
        address _wallet,
        MintableToken _token
        )
        public
        Crowdsale(_rate, _wallet, _token){}
        
        
        
        
    
}


