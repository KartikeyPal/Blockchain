// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0 <0.9.0;

contract questions{
    function question_one(string memory str1,string memory str2) public pure returns(string memory){
        return string.concat(str1,str2);
    }
    function question_two(string memory str1,string memory str2) public pure returns(bool){
        return keccak256(abi.encodePacked(str1))==keccak256(abi.encodePacked(str2));
    }
    function question_three(uint[5] calldata arr,uint num) public pure returns(bool){
        for(uint i=0;i<arr.length;i++){
            if(num==arr[i])
            return true;

        }
        return false;
    }

    function question_four(uint[5] calldata arr) public pure returns(uint){
        uint k;
        for(uint i=0;i<arr.length;i++){
            if(k<arr[i]){
                k=arr[i];
            }
        }
        return k;
    }
    function question_five(uint[5] memory arr) public  pure returns(uint[5] memory) {
        uint i;
        uint j;
        uint temp;
        for( i=0;i<arr.length-1;i++){
            for( j=0;j<arr.length-i-1;j++){
                if(arr[j]>arr[j+1]){
                     temp=arr[j];
                    arr[j]=arr[j+1];
                    arr[j+1]=temp;
                }
            }
        }
        return arr;
    }
    function questionSix(uint[] memory arr) public pure returns (uint[] memory) {
        uint i = 0;
        uint j = arr.length - 1;
        uint temp;
        while (i < j) {
            temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
            i++;
            j--;
        }
        return arr;
    }
    function question_sevel(uint[] memory arr,uint val, uint pos) public pure returns(uint[] memory){
       arr[pos]=val;
       return arr;
    }
    function question_eight(uint[] calldata arr) public pure returns(uint){
        uint add;
        uint i=0;
        while(i<arr.length){
            add+=arr[i];
            i++;
        }
        return add;
    }

}

contract questionsNineandTen{
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

