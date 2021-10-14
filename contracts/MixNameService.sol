pragma solidity ^0.5.6;

import "./klaytn-contracts/ownership/Ownable.sol";
import "./klaytn-contracts/math/SafeMath.sol";
import "./interfaces/IMixNameService.sol";

contract MixNameService is Ownable, IMixNameService {
    using SafeMath for uint256;
}
