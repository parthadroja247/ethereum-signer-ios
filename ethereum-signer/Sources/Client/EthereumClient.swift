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

    func fetchBalance(completion: @escaping (Result<Double, Error>) -> Void) {
        web3.eth.getBalance(address: ethereumPrivateKey.address, block: .latest) { response in
            if let result = response.result {
                completion(.success(result.toDouble()))
            } else if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.failure(EthereumError.generic))
            }
        }
    }

    func sign(message: String) -> String? {
        do {
            let signature = try ethereumPrivateKey.sign(message: message.makeBytes())
            let customSignature = CustomSignature(vBytes: signature.v,
                                                  rBytes: signature.r,
                                                  sBytes: signature.s)
            let encodedString = try JSONEncoder().encode(customSignature).base64EncodedString()
            return encodedString
        } catch {
            return nil
        }
    }
}
