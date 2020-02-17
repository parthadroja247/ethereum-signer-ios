//
//  Error.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 16/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import Foundation

enum EthereumError: Error {
    case generic
}

extension EthereumError: CustomNSError {
    public static var errorDomain: String {
        return Constants.Error.generic
    }

    public var errorCode: Int {
        return -1
    }

    public var errorUserInfo: [String: Any] {
        return [:]
    }
}
