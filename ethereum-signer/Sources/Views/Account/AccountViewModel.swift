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

    func getAccountBalance() -> String {
        EthereumClient.shared.fetchBalance()
        return "BALANCE"
    }
}
