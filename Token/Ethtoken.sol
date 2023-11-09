// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    
    function transferFrom(address sender,address recipient,uint amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

contract Block is IERC20 {
    
    string public name="block";
    string public symbol="BLK";
    uint public decimal=0;
    uint public override totalSupply;
    address public founder;
    mapping(address => uint) public balances;
    mapping(address=> mapping(address=>uint)) public allowed;
    constructor(){
        totalSupply=1000;
        founder=msg.sender;
        balances[msg.sender]=totalSupply;
    }
    function balanceOf(address account) external view override  returns (uint){
        return balances[account];
    }
    function transfer(address recipient, uint amount) external override  returns (bool){
        require(balances[msg.sender]>=amount,"you have insuffcient balance");
        balances[recipient]+=amount;
        balances[msg.sender]-=amount;
        emit Transfer(msg.sender,recipient,amount);
        return true;
    }
 
    function allowance(address owner, address spender) external view override returns (uint){
        return allowed[owner][spender];
       
    }

    function approve(address spender, uint amount) external override returns (bool){
        require(balances[msg.sender]>=amount,"you have insufficent balance");
        require(amount>0,"tokens should be greater than 0");
        allowed[msg.sender][spender]+=amount;
         emit Approval(msg.sender,spender,amount);
         return true;
    }
    
    function transferFrom(address sender,address recipient,uint amount) external override returns (bool){
        require(allowed[sender][recipient]>=amount,"you are not approve for this much of tokens");
        require(balances[sender]>=amount,"you have insufficent balance");
        balances[sender]-=amount;
        balances[recipient]+=amount;
        return true;
    }

}
