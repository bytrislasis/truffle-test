// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract satoshiturk {
  address owner;

  struct Player {
    address player;
    uint    amount;
  }

  Player[] public players;

  uint public totalAmount;
  uint public totalInvest;
  uint public limit;
  uint public yatirmalimiti;

  event Yatirma(address indexed adres, uint amount);
  event Kazanan(address indexed adres, uint amount);


  constructor (){
    owner = msg.sender;
    limit = 2;
    yatirmalimiti  = 1*10**18;

  }

  fallback () external payable onlyOwner{
    require(msg.value !=0,"Yetkisiz Kullanim");
  }

  receive() external payable onlyOwner{
    require(msg.value !=0,"Yetkisiz Kullanim");
  }

  modifier onlyOwner(){
    require(msg.sender == owner,"Sadece yetkili islem yapabilir");
    _;
  }

  function random(uint number) private view returns (uint){
    return uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty,msg.sender))) % number;
  }

  function deposit () payable public {
    require(msg.value >= yatirmalimiti,"Minimum 1 Ethereum ve BNB");
    require(msg.sender != address(0));

    players.push(Player({
    player : msg.sender,
    amount  : msg.value
    }));

    totalAmount += msg.value;
    totalInvest++;

    emit Yatirma(msg.sender,msg.value);


    if(totalInvest == limit){
      winner(players[random(limit)].player);
      delete players;
      totalAmount = 0;
      totalInvest = 0;
    }
  }

  function winner (address _addres) internal {
    uint balance = address(this).balance;
    payable(_addres).transfer(balance);
    emit Kazanan(_addres,balance);
  }

  function setLimit (uint _limit) public onlyOwner {
    limit = _limit;
  }

  function setYatirmaLimiti (uint _limit) public onlyOwner {
    yatirmalimiti = _limit;
  }

  function getLimit() public view returns(uint){
    return limit;
  }

  function gettotalAmount() public view returns(uint){
    return totalAmount;
  }

  function gettotalInvest() public view returns(uint){
    return totalInvest;
  }

  function getyatirmalimiti() public view returns(uint){
    return yatirmalimiti;
  }
}
