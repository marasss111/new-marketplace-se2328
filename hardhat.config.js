require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: {
    version: "0.8.20", // Ensure this matches your contract's Solidity version
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    holesky: {
      url: "https://ethereum-holesky-rpc.publicnode.com", // Holesky Testnet RPC URL
      accounts: [`0x${process.env.PRIVATE_KEY}`], // Load your private key from the .env file
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY, // For verifying contracts on Etherscan (optional)
  },
};
