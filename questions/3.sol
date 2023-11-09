// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract pay{
        event Transfer(address _from,address to,uint _value);

    function sendEther(address to) public payable {
        payable(to).transfer(msg.value);
        emit Transfer(msg.sender,to,msg.value);
    }
}
