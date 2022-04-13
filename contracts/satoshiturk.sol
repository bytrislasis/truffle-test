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
  uint public limit = 5;
  uint public yatirmalimiti = 1*10**18;
  uint public adminPay;



  event Yatirma(address indexed adres, uint amount);
  event Kazanan(address indexed adres, uint amount);


  constructor (){
    owner = msg.sender;
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

    uint adminKazanci = yuzdeHesapla(msg.value,200);


    Player memory p = Player({
    player : msg.sender,
    amount  : msg.value
    });

    players.push(p);


    totalAmount += msg.value-adminKazanci;
    adminPay += adminKazanci;
    totalInvest++;

    emit Yatirma(msg.sender,msg.value);


    if(totalInvest == limit){
      address kazananKisiAdresi   = players[random(limit)].player;
      uint    kazanilanmiktar     = totalAmount;
      winner(kazananKisiAdresi,kazanilanmiktar);
      delete players;
      totalAmount = 0;
      totalInvest = 0;
    }


  }

  function winner (address _addres, uint _amount) internal {

    payable(_addres).transfer(_amount);

    address adminAddress = 0xB9b9B078e7D532A8d75184E17e9Cb45302686CAF;
    payable(adminAddress).transfer(adminPay);

    emit Kazanan(_addres,_amount);
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

  function yuzdeHesapla(uint _amount, uint yuzde) internal pure returns(uint){
    return _amount * yuzde / 10000;
  }

  }


