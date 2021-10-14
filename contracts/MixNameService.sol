pragma solidity ^0.5.6;

import "./klaytn-contracts/token/KIP17/IKIP17.sol";
import "./klaytn-contracts/ownership/Ownable.sol";
import "./klaytn-contracts/math/SafeMath.sol";
import "./interfaces/IMixNameService.sol";
import "./interfaces/IMix.sol";

contract MixNameService is Ownable, IMixNameService {
    using SafeMath for uint256;

    IMix public mix;

    constructor(IMix _mix) public {
        mix = _mix;
    }

    uint256 public mixForChanging = 100 * 1e18;
    uint256 public mixForDeleting = 200 * 1e18;

    mapping(address => string) public names;
    mapping(address => bool) public named;
    mapping(string => bool) public _exists;

    function setMixForChanging(uint256 _mix) onlyOwner external {
        mixForChanging = _mix;
        emit SetMixForChanging(_mix);
    }

    function setMixForDeleting(uint256 _mix) onlyOwner external {
        mixForDeleting = _mix;
        emit SetMixForDeleting(_mix);
    }

    function exists(string calldata name) view external returns (bool) {
        return _exists[name];
    }

    function set(string calldata name) external {
        require(_exists[name] != true);

        if (named[msg.sender] == true) {
            _exists[names[msg.sender]] = false;
        } else {
            named[msg.sender] = true;
        }

        names[msg.sender] = name;
        _exists[name] = true;
        
        mix.burnFrom(msg.sender, mixForChanging);

        emit Set(msg.sender, name);
    }

    function remove() external {

        delete _exists[names[msg.sender]];
        delete names[msg.sender];
        delete named[msg.sender];

        mix.burnFrom(msg.sender, mixForDeleting);

        emit Remove(msg.sender);
    }
}
