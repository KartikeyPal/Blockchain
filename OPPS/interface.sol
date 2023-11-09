// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface book{
    //All interface function is already virtual 
    //so no need to write virtual keyword
    function add(int a,int b) external pure returns (int);
    function sub(int a,int b) external pure returns (int);
    function div(int a,int b) external pure returns (int);
    function mul(int a,int b) external pure returns (int);
}

contract page is book{
    function add(int a,int b) external pure override returns (int){
        return (a+b);
     }
    function sub(int a,int b) external pure override returns (int){
        return a-b;
    }
    function div(int a,int b) external pure override returns (int){
        return a/b;
    }
    function mul(int a,int b) external pure override returns (int){ 
        return a*b;
    }
}