//
//  QRScannerViewModel.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 17/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import Foundation

struct QRScannerViewModel: QRScannerContract {
    func verify(message: String, signature: CustomSignature) -> Bool {
        return EthereumClient.shared.verify(message: message, signature: signature)
    }
}
