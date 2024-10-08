<p align="center">
  <h1 align="center"><a href="https://artifychain.biz/" target="_blank">ArtifyChain</a></h1>
  <p align="center">
    Revolutionizing healthcare data management: blockchain-based medical record storage for patients and insurance companies
  </p>
</p>

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#problem-statement">Problem Statement</a>
    </li>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#running-the-project">Running the project</a></li>
      </ul>
    </li>
    <li>
      <a href="#future-prospects">Future Prospects</a>
    </li>
  </ol>
</details>

## ℹ️ Problem Statement

The data privacy of patients is essential because it involves sensitive personal information, such as medical records, test results, and health history. If this data is not handled securely, it can result in various consequences, such as financial loss, identity theft, damage to reputation, and even physical harm. It can also lead to discrimination, as individuals with certain health conditions may face challenges in obtaining health insurance.

## ℹ️ About The Project

Our project *ArtifyChain* seeks to address these challenges by leveraging the power of blockchain to create a secure, decentralized platform for storing and sharing healthcare data. By doing so, we hope to empower patients and insurance providers to make more informed decisions, improve outcomes, and advance the field of healthcare as a whole.

## ℹ️ Future Prospects

1. We will be implementing insurance policy as ERC-721 Standard (i.e., Non-Fungible Tokens) to specify the uniqueness and ownership of each insurance policy.
2. We will be giving patients the flexibility to buy health insurance policies according to their preferences instead of predefined policies by the insurance provider.
3. We will predict policy annual premium amounts using Machine Learning techniques based on factors like a patient's age, location, etc.

## 🛠️ Built With

![img1](https://user-images.githubusercontent.com/66792720/232314435-eaf54582-deb5-4970-ab55-2d9bf8976020.jpeg)

Following technologies and libraries are used for the development of this project:

- [React](https://reactjs.org/)
- [Solidity](https://soliditylang.org/)
- [Truffle](https://trufflesuite.com/)
- [Mocha](https://mochajs.org/)
- [Chai](https://chaijs.com/)
- [Infura](https://infura.io/)

<!-- GETTING STARTED -->

## 📌 Installation

To set up the project locally, follow the steps below:

### 💻 Prerequisites

- [Node.js](https://nodejs.org/en/download/)
- [Ganache](https://trufflesuite.com/ganache/)
- [Metamask Wallet Extension](https://metamask.io/) or a Web3-enabled browser like Brave

### 🤖 Running the project

1. **Fork** and **clone** the project to your local system.
2. Copy the commands below to install the dependencies:

   ```bash
   npm i -g truffle
   npm run client:install
   npm run truffle:install


3. Now, start a local Ethereum blockchain network on your system using Ganache. Ganache provides you with 10 testing accounts each with 100 ETH. 

4. Obtain Infura API Key and API Secret for IPFS from [Infura Dashboard](https://infura.io/), and create a dedicated gateway for your project. Set the environment variables in `client/.env` file. Or you can rename `client/.env.example` to `client/.env`
```bash
REACT_APP_INFURA_PROJECT_ID=...
REACT_APP_INFURA_API_KEY_SECRET=...
REACT_APP_INFURA_DEDICATED_GATEWAY=....
```

5. Then, copy the following commands to deploy the smart contracts to the local Ethereum blockchain and start the React app:

```
npm run truffle:migrate
npm run client:start
```

6. Set up Metamask to connect to the local blockchain created by Ganache(i.e. [http://localhost:8545/](http://localhost:8545/))

7. Now, obtain the private keys of some of the accounts from Ganache and import the accounts into Metamask wallet.

8. You're ready to go. Visit [http://localhost:3000/](http://localhost:3000/) to check out ArtifyChain