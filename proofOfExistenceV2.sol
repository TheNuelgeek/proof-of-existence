// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract POF {
    // A contract to proof an existence of a data
    // case study: LAND

    /**
    GOALS
    =============
    1. only govt can a Register land
    2. land owners should be able to check their landid using their Addr 
    3. Outsiders should be able to confirm land details using their  id
    */

    // VARIABLES
    uint256 ID = 1;
    address govt;

    struct land{
        uint ID;
        uint256 num_of_plots;
        string landOwner;
        string location;
        address ownerAddr;
    }

    //land[] lands;
    mapping(address => uint) OwnerToID;
    mapping(uint => land) IdTolandInfo;

    //FUNCTIONS

    constructor(){
        govt = msg.sender;
    }

    modifier onlyGovt{
        require(msg.sender == govt, "only the govt can register a land");
        _;
    }

    function registerLand(address _ownerAddr, string memory _name, string memory _location, uint numOfPlot)public onlyGovt{
        land storage Land = IdTolandInfo[ID];
        Land.num_of_plots = numOfPlot;
        Land.landOwner = _name;
        Land.location = _location;
        Land.ownerAddr = _ownerAddr;

        ID++;
    }

    function confrimRegisteredLand(uint _id) external view returns(land memory x){
       x = IdTolandInfo[_id];
    }
    //

    function seeLandDb(uint howmanyLand) external view returns(land[] memory x){
       require (howmanyLand <= ID, "we don't have more than this");
       x = new land[](howmanyLand);
       for(uint i = 0; i < howmanyLand; i++){
           x[i] = IdTolandInfo[i+1];
       }
    }
}