// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract data{
    uint l;
    uint b;
    uint h;
    function setDimension(uint _l,uint _b,uint _h) public {
        l=_l;
        b=_b;
        h=_h;
    }
    function getDimension() public view returns(uint,uint,uint){
        return(l,b,h);
    }
}

contract obj{
    data obj=new data();
    function setdi(uint l,uint b,uint h) public {
        obj.setDimension(l, b, h);
    }
   

}