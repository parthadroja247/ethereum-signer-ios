//
//  SetupViewModel.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 16/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import Foundation
import Web3

struct SetupViewModel: SetupContract {
    func validatePrivateKey(key: String) -> (EthereumPrivateKey?, Error?) {
        do {
            let key = try EthereumPrivateKey(hexPrivateKey: key)
            return (key, nil)
        } catch {
            return (nil, error)
        }
    }

    func configureEthereumClient(key: EthereumPrivateKey) {
        EthereumClient.shared.ethereumPrivateKey = key
    }
}
