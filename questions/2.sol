// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 <0.9.0;

contract questions{
    struct student{
        string name;
        uint rollno;
        uint age;
    }
    function setter(string memory _name,uint _rollno,uint _age) public pure returns(student memory){
        student memory s1;
        s1.name=_name;
        s1.rollno=_rollno;
        s1.age=_age;
        return s1;
    }
    student[] students;
     uint index;
    function input(string memory _name,uint _rollno,uint _age) public {
        students[index].name=_name;
        students[index].age=_age;
        students[index].rollno=_rollno;
        index++;
    }
    function getter() public view returns(student[] memory){
        return students;
    }
}
contract questionEleven{
    mapping(address=>uint[3]) studentMarks;

    function setMarks(uint Maths,uint english,uint history) public {
        studentMarks[msg.sender]=[Maths,english,history];
    }
    function getmarks() public view returns (uint[3] memory){
        return studentMarks[msg.sender];
    }
}

contract questionTwelve{
    struct student{
        string name;
        uint rollno;
        uint age;
    }

    mapping(address=>student) students;

    function setter(string calldata _name,uint _rollno,uint _age) public {
        students[msg.sender].name=_name;
        students[msg.sender].age=_age;
        students[msg.sender].rollno=_rollno;
    }
    function get() public view returns(student memory){
        return students[msg.sender];
    }

}

contract questionThirteen{
    mapping(address=>mapping(address=>bool)) owner;
    function ownership(address  from,address  to) public {
        owner[from][to]=true;
    }
    function ownershipStatus(address from,address to) public view returns(bool){
        return owner[from][to];
    }
}

contract questionFourteen{
    string[] arr;
    function push(string memory _val) public {
        arr.push(_val);
    }
    function pop() public{
        arr.pop();
    }
    function returnarr() public view returns(string[] memory){
        return arr;
    }

}

contract questionfivteen{
    enum hotel{small,medium,large} 
    hotel choice;

    function size(hotel val) public{
        choice=val;
    }
    function getsize() public view returns(hotel){
        return choice;
    }
}
