pragma solidity ^0.5.6;

import "../klaytn-contracts/token/KIP17/IKIP17.sol";

interface IMixNameService {

    event SetMixForChanging(uint256 _mix);
    event SetMixForDeleting(uint256 _mix);

    event Set(address indexed owner, string name);
    event Remove(address indexed owner);

    function mix() view external returns (IKIP17);
    function mixForChanging() view external returns (uint256);
    function mixForDeleting() view external returns (uint256);

    function names(address owner) view external returns (string memory name);
    function named(address owner) view external returns (bool);
    function exists(string calldata name) view external returns (bool);
    function set(string calldata name) external;
    function remove() external;
}
