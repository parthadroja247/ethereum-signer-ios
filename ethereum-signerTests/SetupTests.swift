//
//  SetupTests.swift
//  ethereum-signerTests
//
//  Created by Parth Adroja on 21/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

@testable import ethereum_signer
import XCTest

class SetupTests: XCTestCase {
    struct MockData {
        static let validPrivateKey = "9857D8DCDE92863801FD47DD1CBEF610194748C78A12D99D5D97F478CE3C5271"
        static let invalidPrivateKey = "InvalidKey"
    }

    private var contract: SetupViewModel!

    override func setUp() {
        contract = SetupViewModel()
    }

    override func tearDown() {
        contract = nil
    }

    func testContractNotNil() {
        XCTAssertNotNil(contract)
    }

    func testValidEthereumPrivateKey() {
        let result = contract.validatePrivateKey(key: MockData.validPrivateKey)
        XCTAssertNotNil(result.0)
        XCTAssertNil(result.1)
    }

    func testInvalidEthereumPrivateKey() {
        let result = contract.validatePrivateKey(key: MockData.invalidPrivateKey)
        XCTAssertNotNil(result.1)
        XCTAssertNil(result.0)
    }

    func testConfigureEhtereumClient() {
        let result = contract.validatePrivateKey(key: MockData.validPrivateKey)
        XCTAssertNotNil(result.0)
        contract.configureEthereumClient(key: result.0!)
        XCTAssertNotNil(EthereumClient.shared.ethereumPrivateKey)
    }
}
