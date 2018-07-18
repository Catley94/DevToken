pragma solidity ^0.4.24;

import "./LeaderboardList.sol";
import "./Ownable.sol";
import "./BondingCurve.sol";

//Changed instances of impl to "used" for user friendly code.
//For Example require(_implementation != used);
contract Proxy is Ownable {

  event Upgraded(address indexed implementation);

  address internal _implementation;

  function implementation() public view returns (address) {
    return _implementation;
  }

  function upgradeTo(address used) public onlyOwner {
    require(_implementation != used);
    _implementation = used;
    emit Upgraded(used);
  }

  function () payable public {
    address _used = implementation();
    require(_used != address(0));
    bytes memory data = msg.data;

    assembly {
      let result := delegatecall(gas, _used, add(data, 0x20), mload(data), 0, 0)
      let size := returndatasize
      let ptr := mload(0x40)
      returndatacopy(ptr, 0, size)
      switch result
      case 0 { revert(ptr, size) }
      default { return(ptr, size) }
    }
  }

}
