# Ethereum Signer

Ethereum Signer is iOS application. It's very simple to use app. It allows to sign and verify message based on Ethereum Private Key. Also, allows to find the ethereum balance.

# Tips

- Checkout the project from **develop** branch 
- Install pods

## Features
- View ethereum balance
- Sign and verify message with private key
- Generate QR code, Scan QR code to validate the message

## Dependencies
- SwiftLint
- Web3

## Environment
- Dev
- Sit
- Uat
- Production

## Architecture: MVVM + Contract
- Contract: It is a protocol which contains all the functions related to business logic. 
- View Model: View Model is confirms the contract protocol. All the method implementation is added here.

## EthereumClient
It is shared class. It is responsible to connect and make requests. Web3 is configured with test **rinkbyEndpoint**.

### func:
- fetchBalance: It request getBalance api of web3 client to get the ethereum balance from the ethereum address using ethereum private key.

- sign: It accepts a string value and returns a custom signature of message.

- verify: It accepts a message and custom signature to validate the message passed is valid or invalid based on the private key.
