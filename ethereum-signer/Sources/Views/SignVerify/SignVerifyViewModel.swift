//
//  SignVerifyViewModel.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 16/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import Foundation

struct SignVerifyViewModel: SignVerifyContract {
    func sign(message: String) -> (Bool, String) {
        let signedMessage = EthereumClient.shared.sign(message: message)
        guard let message = signedMessage else {
            return (false, "")
        }
        return (true, message)
    }
}
