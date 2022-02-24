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
    uint256 ID = 1000;
    address govt;

    struct land{
        uint ID;
        uint256 num_of_plots;
        string landOwner;
        string location;
    }

    land[] lands;
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

    function registerLand(address _owner, string memory _name, string memory _location, uint numOfPlot)public onlyGovt returns(bool, uint) {
        if(addressExist(_owner)){
            return(false, OwnerToID[_owner]);
        }

        ID++;
        land memory newLandOwner = land(ID, numOfPlot,_name, _location);

        lands.push(newLandOwner);
        OwnerToID[_owner] = ID;
        
        IdTolandInfo[ID] = newLandOwner;
        
        return(true, ID);
    }


    function confrimRegisteredLand(uint _id) external view returns(land memory){
        return IdTolandInfo[_id];
    }

    function retriveLandOwnerID() external view returns(bool, uint){
        uint _id = OwnerToID[msg.sender];

        if ( _id == 0) return (false, 0);

        return (true, _id);
    }

    function addressExist(address _owner) private view returns(bool){
         return !(OwnerToID[_owner] == 0);   
    }

    function getLand() public view returns  (land[] memory) {
        return lands;
    }
}