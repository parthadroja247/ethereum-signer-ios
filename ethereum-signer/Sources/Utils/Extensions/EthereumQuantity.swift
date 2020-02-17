//
//  EthereumQuantity.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 17/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import Foundation
import Web3

extension EthereumQuantity {
    func toDouble() -> Double {
        let doubleValue = Double(quantity) / pow(10, 18)
        return doubleValue
    }
}
