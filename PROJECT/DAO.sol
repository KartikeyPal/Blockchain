// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 < 0.9.0;

contract dao{
    struct Proposal{
        uint id;
        string description;
        uint amount;
        address payable recepient;
        uint votes;
        uint end;
        bool isexecuted;
    }

    mapping(address=>bool) private isInvestor;
    mapping(address=>uint) public numOfshares;
    mapping(address=>mapping(uint=>bool)) public isVoted;
    address[] public investorList;
    
    mapping(uint=>Proposal) public proposals;
    uint public totalsShares;
    uint private availableFunds;
    uint public contributionTimeEnd;
    uint public nextProposalId;
    uint public voteTime;
    uint public quorum;
    address public manager;


    constructor(uint _contributionTimeEnd,uint _voteTime,uint _quorum){
        require(_quorum>0 && _quorum<100,"Not valid values");
        contributionTimeEnd=block.timestamp+_contributionTimeEnd;
        voteTime=_voteTime;
        quorum=_quorum;
        manager=msg.sender;

    }
    modifier onlyInvestor(){
        require(isInvestor[msg.sender]==true , "You're not an investor");
        _;
    }
    modifier onlyManager(){
        require(manager==msg.sender , "You're not an manager");
        _;
    }
    function contribution() public payable{
        require(contributionTimeEnd>=block.timestamp,"Time has ended");
        require(msg.value>0,"Your amount should be greater than 0");
        numOfshares[msg.sender]+=msg.value;
        isInvestor[msg.sender]=true;
        totalsShares+=msg.value;
        investorList.push(msg.sender);
        availableFunds+=msg.value;

    }

    function redeemShare(uint amount) public payable onlyInvestor(){
        require(numOfshares[msg.sender]>=amount,"You don't have enough shares");
        require(availableFunds>=amount,"available funds is not enough");
        numOfshares[msg.sender]-=amount;
        if(numOfshares[msg.sender]==0){
            isInvestor[msg.sender]=false;
        }

        availableFunds-=amount;
        payable(msg.sender).transfer(amount);

    }

    function transfer(uint amount,address  _to) public payable onlyInvestor(){
        require(availableFunds>=amount,"available funds is not enough");
        require(numOfshares[msg.sender]>=amount,"You don't have enough shares");
        numOfshares[msg.sender]-=amount;
        if(numOfshares[msg.sender]==0){
            isInvestor[msg.sender]=false;
        }
        isInvestor[_to]=true;
        numOfshares[_to]+=amount;
        investorList.push(_to);

    }

    function createrproposal(string calldata _description,uint _amount,address payable _receiver)public payable onlyManager(){
        require(_amount<=availableFunds,"not enough funds");
        proposals[nextProposalId]=Proposal(nextProposalId,_description,_amount,
        _receiver,0,block.timestamp+voteTime,false); 
        nextProposalId++;

    }

    function  voteProposal(uint _proposalId) public onlyInvestor(){
        Proposal storage proposal = proposals[_proposalId];
        require(isVoted[msg.sender][_proposalId]==false,"you have already votes for this proposal");
        require(proposal.end>=block.timestamp,"voting time has already ended");
        require(proposal.isexecuted==false,"proposal is already executed"); 
        isVoted[msg.sender][_proposalId];
        proposal.votes+=numOfshares[msg.sender];
        
        }

    function exectuteProposal(uint _proposalId) public onlyManager(){
        Proposal storage proposal=proposals[_proposalId];
        require(proposal.isexecuted==false,"already executed");
        require((proposal.votes)*100/totalsShares>=quorum,"majority votes percentage is low please select another _proposalId");
        proposal.isexecuted=true;
        _transfer(proposal.recepient,proposal.amount);
    }

    function _transfer(address payable _recepient,uint amount) private{
        _recepient.transfer(amount);
        availableFunds-=amount;
    }
    function PropsalList() public view returns(Proposal[] memory){
        Proposal[] memory arr = new Proposal[](nextProposalId-1);
        for(uint i=0;i<nextProposalId;i++){
            arr[i]=proposals[i];
        } 
        return arr;
    }
}