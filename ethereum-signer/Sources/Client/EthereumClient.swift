//
//  EthereumClient.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 16/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import Foundation
import Web3

final class EthereumClient {
    static let shared = EthereumClient()
    let web3: Web3
    var ethereumPrivateKey: EthereumPrivateKey!

    private init() {
        var environment = EnvironmentConfiguration()
        web3 = Web3(rpcURL: environment.current.rinkbyEndpoint)
    }

    func getAddress() -> String {
        let address = ethereumPrivateKey.address.hex(eip55: false)
        return address
    }

    func fetchBalance() {
        web3.eth.getBalance(address: ethereumPrivateKey.address, block: .latest) { response in
            if let result = response.result {
            } else {}
        }
    }
}
