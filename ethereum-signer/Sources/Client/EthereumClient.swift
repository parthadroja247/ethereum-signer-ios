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

    var ethereumPrivateKey: EthereumPrivateKey!

    private lazy var web3: Web3 = {
        var environment = EnvironmentConfiguration()
        return Web3(rpcURL: environment.current.rinkbyEndpoint)
    }()
}
