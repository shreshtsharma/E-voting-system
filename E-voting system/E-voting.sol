//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;

contract voting{

    struct voter{
        uint aadhar_number;
        string name;
        uint age;
        uint statecode;
        bool alive;
        uint voted_to;
        bool voted;
    }
    struct candidate {
        string name;
        uint partycode;
        uint statecode;
        uint votes;
    }
    address public electioncommision;
    constructor(){
        electioncommision=msg.sender;
    }
    mapping (uint=>voter) public voters;
    mapping(uint=>candidate) public candidates;
    function AddVoter(uint aadhar,string memory _name,uint _age,uint code,bool alive,bool _voted) external
    {
        require(msg.sender==electioncommision);
        require(alive==true);
        require(_voted==false);
        require(_age>=18);
        voters[aadhar]=voter(aadhar,_name,_age,code,alive,0,_voted);
    }
    function AddCandidate(string memory _name,uint pcode,uint scode) external{
        require(msg.sender==electioncommision);
        candidates[pcode]=candidate(_name,pcode,scode,0);
    }
    function castvote(uint aadhar,uint pcode) public 
    {
        require(voters[aadhar].aadhar_number!=0,"sorry your name is not present in voter's list");
        require(voters[aadhar].voted==false,"you already casted your vote");
        require(candidates[pcode].statecode==voters[aadhar].statecode);
        voters[aadhar].voted=true;
        voters[aadhar].voted_to=pcode;
        candidates[pcode].votes++;
    }
   

}
    