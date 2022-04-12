const satoshiturk = artifacts.require("../contracts/satoshiturk.sol");

module.exports = function (deployer) {
    deployer.deploy(satoshiturk);
};
