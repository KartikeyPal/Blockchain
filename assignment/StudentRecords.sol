// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 < 0.9.0;

contract StudentRecords{
    address public owner;
    constructor(){
        owner=msg.sender;
    }
    struct student{
        uint rollno;
        string name;
        uint[] marks;
    }
    mapping(uint=>student) private students;
    function addRecords(uint _rollno,string calldata _name,uint[3] calldata _marks) public {
        require(msg.sender==owner,"You are not the owner");
        students[_rollno].rollno= _rollno;
        students[_rollno].name= _name;
        students[_rollno].marks= _marks;
    }
    function getRecord(uint _rollNo) public view returns(student memory){
        require(msg.sender==owner,"You are not the owner");
        return students[_rollNo];
    }
    function deleteRecord(uint _rollNo) public {
        require(msg.sender==owner,"You are not the owner");
        delete students[_rollNo];

    }

}