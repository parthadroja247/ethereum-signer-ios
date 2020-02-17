//
//  Constants.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 16/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import Foundation

struct Constants {
    struct Title {
        static let setup = "Setup"
        static let account = "Account"
        static let sign = "Signing"
        static let verify = "Verification"
        static let signature = "Signature"
        static let qrScanner = "QR Code Scanner"
    }

    struct Placeholder {
        static let privateKey = "Private Key"
        static let address = "Address"
        static let balance = "Balance"
        static let yourMessage = "Your message"
    }

    struct Error {
        static let generic = "Something went wrong"
    }

    struct Alert {
        static let okButton = "OK"
        static let success = "Success"
        static let oops = "OOPS"
        static let validSignature = "Signature is Valid"
        static let invalidSignature = "Signature is Invalid"
    }
}
