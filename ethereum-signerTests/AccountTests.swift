//
//  AccountTests.swift
//  ethereum-signerTests
//
//  Created by Parth Adroja on 22/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

@testable import ethereum_signer
import XCTest

class AccountTests: XCTestCase {
    struct MockData {
        static let validPrivateKey = "9857D8DCDE92863801FD47DD1CBEF610194748C78A12D99D5D97F478CE3C5271"
        static let address = "0x376b7a263b2b1465f0ad7654aa89a2ea16ddc254"
        static let getAccount = "getAccount"
        static let currentBalance = 18.75
    }

    private var contract: AccountViewModel!

    override func setUp() {
        configureClient()
        contract = AccountViewModel()
    }

    override func tearDown() {
        EthereumClient.shared.reset()
    }

    private func configureClient() {
        let contract = SetupViewModel()
        let result = contract.validatePrivateKey(key: MockData.validPrivateKey)
        XCTAssertNotNil(result.0)
        EthereumClient.shared.ethereumPrivateKey = result.0!
        XCTAssertNotNil(EthereumClient.shared.ethereumPrivateKey)
    }

    func testGetAccountAddress() {
        let address = contract.getAccountAddress()
        XCTAssertNotNil(address)
        XCTAssertEqual(address, MockData.address)
    }

    func testGetAccountBalance() {
        let expectation = self.expectation(description: MockData.getAccount)
        contract.getAccountBalance { result in
            switch result {
            case let .success(balance):
                XCTAssertNotNil(balance)
                XCTAssertEqual(balance, MockData.currentBalance)
                expectation.fulfill()
            case .failure:
                XCTFail("Failed")
            }
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
}
