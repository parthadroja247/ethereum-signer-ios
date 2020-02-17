//
//  QRScannerContract.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 17/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import Foundation

protocol QRScannerContract {
    func verify(message: String, signature: CustomSignature) -> Bool
}
