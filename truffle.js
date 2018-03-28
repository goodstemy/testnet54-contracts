module.exports = {
  networks: {
    testnet54: {
      host: "testnet54.kenig.pw",
      port: 8545,
      network_id: "*",
      from: "0xd632B642D0F2dD47807619f419Bf10f2F620F954"
    },
    ganache: {
    	host: "127.0.0.1",
    	port: 7545,
    	network_id: "5777"
    }
  }
};
