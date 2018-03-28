var ValidatorsList = artifacts.require("./ValidatorsList.sol");

module.exports = function(deployer) {
  deployer.deploy(ValidatorsList);
};
