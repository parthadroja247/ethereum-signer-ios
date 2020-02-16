//
//  AccountContract.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 16/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import Foundation

protocol AccountContract {
    func getAccountAddress() -> String
    func getAccountBalance() -> String
}
