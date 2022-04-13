const satoshiturk = artifacts.require("../contracts/satoshiturk.sol");

contract("satoshiturk", function (accounts) {

  it("Limit Değişikliği", async function () {
    let instance = await satoshiturk.deployed();
    let result = await instance.setLimit(10, { from: accounts[0] });
    return assert.isTrue(true);
  });

  it("Limit Gör", async function () {
    let instance = await satoshiturk.deployed();
    let result = await instance.getLimit({ from: accounts[0] });
    assert.equal(result.toString(), 10,"Limit 10 olmalı");
  });

  it("Total Amonut", async function () {
    let instance = await satoshiturk.deployed();
    let result = await instance.gettotalAmount({ from: accounts[0] });
    assert.equal(result.toString(), 0,"Amount 0 olmalı");
  });

  it("Total Invest", async function () {
    let instance = await satoshiturk.deployed();
    let result = await instance.gettotalInvest({ from: accounts[0] });
    assert.equal(result.toString(), 0,"Invest 10 olmalı");
  });

  it("Yatırma Limiti Değişti", async function () {
    let instance = await satoshiturk.deployed();
    let result = await instance.setYatirmaLimiti(web3.utils.toBN(2), { from: accounts[0] });
  });

  it("Cekilise Katılma Limiti", async function () {
    let instance = await satoshiturk.deployed();
    let result = await instance.getyatirmalimiti({ from: accounts[0] });
  });

  it("Cekilise Katıl", async function () {
    let instance = await satoshiturk.deployed();
    for (let i = 0; i < accounts.length; i++) {
      await instance.deposit({ from: accounts[i], value: 2*10**18 });
      web3.eth.getBalance(instance.address).then(console.log);
    }
  });

});