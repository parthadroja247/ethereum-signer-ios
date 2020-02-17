//
//  CustomSignature.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 17/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import Foundation
import Web3

struct CustomSignature: Codable {
    let vBytes: UInt
    let rBytes: Bytes
    let sBytes: Bytes
}
