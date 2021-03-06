const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {

  networks: {
     development: {
      provider: () => new HDWalletProvider("Kelimeler veya Private Key veya KEYS", 'http://127.0.0.1:8555'),
      host: "127.0.0.1",     // Localhost (default: none)
      port: 8555,            // Standard Ethereum port (default: none)
      network_id: "*",       // Any network (default: none)
     },
     ropsten: {
      provider: () => new HDWalletProvider("Kelimeler veya Private Key veya KEYS", `http://127.0.0.1:8555`),
     network_id: 3,       // Ropsten's id
     gas: 5500000,        // Ropsten has a lower block limit than mainnet
     confirmations: 2,    // # of confs to wait between deployments. (default: 0)
     timeoutBlocks: 200,  // # of blocks before a deployment times out  (minimum/default: 50)
     skipDryRun: true     // Skip dry run before migrations? (default: false for public nets )
     },
  },
  mocha: {
    // timeout: 100000
  },

  compilers: {
    solc: {
      version: "0.8.13",      // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {          // See the solidity docs for advice about optimization and evmVersion
      //  optimizer: {
      //    enabled: false,
      //    runs: 200
      //  },
      //  evmVersion: "byzantium"
      // }
    }
  },
};
