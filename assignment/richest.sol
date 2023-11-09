// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Richest{
    address payable richest;
    uint max;
    constructor() payable{
         max=msg.value;
         richest=payable(msg.sender);
         richest.transfer(max);
    }
    function richestPerson() public payable returns(uint){
        require(msg.value>max,"you are not the richest person");
        max=msg.value;
        richest=payable(msg.sender);
        richest.transfer(max);
        return max;
    }
}