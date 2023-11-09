// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

contract voting{
    address electionCommision;
    address public winner;

    struct voter{
        string name;
        uint age;
        uint voterId;
        string gender;
        uint voteCandidateId;
        address voteraddress;
    }

    struct candidate {
        string name;
        string party;
        uint age;
        uint candidateId;
        string gender;
        address candidateAddress;
        uint votes;
    }

    uint nextVoterId=1;
    uint nextCandidateId=1;

    uint startTime;
    uint endTime;

    mapping(uint=> voter) voterDetails;
    mapping(uint => candidate) candidateDetails;
    bool stopVoting=false;

    constructor(){
        electionCommision=msg.sender;
    }

    modifier isVotingOver(){
        require(block.timestamp> endTime || stopVoting==true);
        _;
    }

    modifier onlyElectionCommission(){
        require(msg.sender==electionCommision);
        _;
    }


    function candidateRegister(string calldata _name,string calldata _party,uint _age,string calldata _gender) public {
        require(msg.sender!=electionCommision,"election commission not allowed");  
        require(candidatevarification(msg.sender)==true,"you are already register");

        require(_age>=18,"You are under age");
        candidateDetails[nextCandidateId]=candidate(_name,_party,_age,nextCandidateId,_gender,msg.sender,0);
        nextCandidateId++;
    }

    function candidatevarification(address _candidate) internal view returns (bool){
        for(uint i=0;i<nextCandidateId;i++){
            if(candidateDetails[i].candidateAddress==_candidate){
                return false;
            }
        }
        return true;
    }

    function candidateList() public view returns(candidate[] memory){
        candidate[] memory arr= new candidate[](nextCandidateId-1);
        for(uint i=1;i<nextCandidateId;i++){
            arr[i-1]=candidateDetails[i];
        }
        return arr;
    }



    function voterRegister(string calldata _name,uint _age,string calldata _gender) public {
        require(_age>17,"You are under age");
        require(voterVerification(msg.sender)==true,"you are already register");
        voterDetails[nextVoterId]=voter(_name,_age,nextVoterId,_gender,0,msg.sender);
        nextVoterId++;
    }

    function voterVerification(address _voter) internal view returns(bool){
        for(uint i=1;i<nextVoterId;i++){
            if(voterDetails[i].voteraddress==_voter){
                return false;
            }
        }
        return true;
    }

    function voterList() public view returns(voter[] memory){
        voter[] memory arr= new voter[](nextVoterId-1);
        for(uint i=0;i<nextVoterId;i++){
            arr[i-1]=voterDetails[i];
        }
        return arr;
    }
    

    function vote(uint _voterID,uint _candidateID) public {
        require(voterDetails[_voterID].voteraddress==msg.sender,"enter a valid ID");
        require(_candidateID<nextCandidateId && _candidateID>0,"enter a valid candidate ID");
        require(voterDetails[_voterID].voteCandidateId==0,"you already voted");
        require(startTime!=0,"voting not started yet");
        voterDetails[_voterID].voteCandidateId=_candidateID;
        candidateDetails[_candidateID].votes++;
    }
  
    
    function voteTime(uint _startTime,uint _endTime) external onlyElectionCommission{
       startTime=block.timestamp+_startTime;
       endTime=startTime+_endTime;
    }

    function votingStatus() public view returns(string memory){
        require(startTime>0,"voting not started yet");
        require(endTime<=block.timestamp,"voting has ended");
        require(stopVoting==false,"voting has ended");
        return "voting in progress";
    }

    function result() public view returns(address){
        uint mx=0;
        uint ans;
        for(uint i=1;i<nextCandidateId;i++){
            if(mx<candidateDetails[i].votes){
                mx=candidateDetails[i].votes;
                ans=i;
            }
        }
        return candidateDetails[ans].candidateAddress;
    }

    function emergency() public onlyElectionCommission{
        stopVoting=true;
    }

}