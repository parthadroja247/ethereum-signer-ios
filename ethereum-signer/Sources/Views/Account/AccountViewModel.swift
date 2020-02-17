//
//  AccountViewModel.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 16/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import Foundation

struct AccountViewModel: AccountContract {
    func getAccountAddress() -> String {
        return EthereumClient.shared.getAddress()
    }

    func getAccountBalance(completion: @escaping (Result<Double, Error>) -> Void) {
        EthereumClient.shared.fetchBalance { result in
            completion(result)
        }
    }
}
