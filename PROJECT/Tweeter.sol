// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Tweeter{
    struct Tweet{
        uint id;
        address author;
        string content;
        uint createdAt;
    }
    struct message{
        uint id;
        string content;
        address from;
        address to;
        uint createdAt;
    }
    mapping(uint=>Tweet) private tweets;
    mapping(address=>uint[]) private tweetOf;
    mapping(address=>message[]) private conversations;
    mapping(address=>mapping(address=>bool)) private  operators;
    mapping(address=>address[]) private followers;

    uint nextId;
    uint nextMessageId;

    function _tweet(address _from,string memory content) internal {
        tweets[nextId]=Tweet(nextId,_from,content,block.timestamp);
        nextId++;
    }
    function _sendmessage(address _from,address _to,string memory content) internal {
        conversations[_from].push(message(nextMessageId,content,_from,_to,block.timestamp));
        nextMessageId++;
    } 
    function tweet(string memory _content) public{
        _tweet(msg.sender,_content);

    }
    function tweet(address _from,string memory _content) public{
        _tweet(_from,_content);
    }
    function sendmessage(string memory _content,address _to) public{
        _sendmessage(msg.sender, _to, _content);
    }
    function tweet(address _from,address _to,string memory content) public{
        _sendmessage(_from, _to, content);
    }
    function follow(address _followed) public{
        followers[msg.sender].push(_followed);
    }
    function allow(address _operator) public{
        operators[msg.sender][_operator]=true;
    }
    function disallow(address _operator) public{
        operators[msg.sender][_operator]=false;
    }
    function getLatestTweets(uint count) public view returns(Tweet[] memory){
        require(count>0 && count<nextId,"count is not proper");
        Tweet[] memory _tweets = new Tweet[](count);
        uint k;
        for(uint i=nextId-count;i<nextId;i++){
            Tweet storage _structure = tweets[i];
            _tweets[k]= Tweet(_structure.id,_structure.author,_structure.content,_structure.createdAt);
            k++;
        }
        return _tweets;
    }
    function getLatestofUser(address _user,uint count) public view returns(Tweet[] memory){
        require(count>0 && count<=nextId,"count is not define");
        // tweetOf[_user];

        Tweet[] memory _tweets = new Tweet[](count);
        uint[] memory ids= tweetOf[_user];
         require(count>0 && count<=ids.length,"count is not properly define");
        uint k;
        for(uint i=ids.length-count;i<ids.length;i++){
            Tweet storage _structure = tweets[ids[i]];
            _tweets[k]= Tweet(_structure.id,_structure.author,_structure.content,_structure.createdAt);
            k++;
        }
        return _tweets;
    }
}