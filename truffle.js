// const Web3 = require("web3");

module.exports = {
  networks: {
    testnet54: {
      host: "testnet54.kenig.pw",
      port: 8545,
      network_id: "*",
      from: "0xd632b642d0f2dd47807619f419bf10f2f620f954",
      provider: web3.providers.HttpProvider("testnet54.kenig.pw:8545")
    },
    ganache: {
    	host: "127.0.0.1",
    	port: 7545,
    	network_id: "5777"
    }
  }
};
