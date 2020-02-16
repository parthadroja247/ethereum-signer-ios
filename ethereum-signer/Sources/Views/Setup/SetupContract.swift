//
//  SetupContract.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 16/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import Foundation
import Web3

protocol SetupContract {
    func validatePrivateKey(key: String) -> (EthereumPrivateKey?, Error?)
    func configureEthereumClient(key: EthereumPrivateKey)
}
