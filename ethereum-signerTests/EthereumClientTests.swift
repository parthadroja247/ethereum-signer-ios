//
//  EthereumClientTests.swift
//  ethereum-signerTests
//
//  Created by Parth Adroja on 21/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

@testable import ethereum_signer
import XCTest

class EthereumClientTests: XCTestCase {
    struct MockData {
        static let validPrivateKey = "9857D8DCDE92863801FD47DD1CBEF610194748C78A12D99D5D97F478CE3C5271"
        static let address = "0x376b7a263b2b1465f0ad7654aa89a2ea16ddc254"
        static let getAccount = "getAccount"
        static let currentBalance = 18.75
        static let message = "Hello Ehter"
        static let message2 = "Hello Parth"
        // swiftlint:disable line_length
        static let signedMessage = "eyJyQnl0ZXMiOlsxNjIsNDYsNDAsMTI4LDMsMTA2LDI1MSw1MCwxMDIsMTI1LDE1NywxNiwxOSwxMjgsMTg5LDQ0LDE5MCwxMDgsMTEwLDE2MywxNDQsMTQ0LDEzMCwxNDQsMTE2LDE0MCwyMzYsMjMxLDk0LDIzMCwxOSwxNThdLCJ2Qnl0ZXMiOjEsInNCeXRlcyI6WzY4LDE5NCwxMjcsMTU2LDgxLDIxNSw3MCw1OCwxODMsNTUsMjUsNjgsMTI1LDEzNSwxNjQsMTg4LDE0NCwyMjQsMzUsMTAyLDEyMywzOCw2MSw3NiwyMCwxNDAsNjcsMTQ1LDE0OCwxNjMsMTk0LDE3N119"
        // swiftlint:enable line_length
    }

    override func setUp() {
        configureClient()
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
        let address = EthereumClient.shared.getAddress()
        XCTAssertNotNil(address)
        XCTAssertEqual(address, MockData.address)
    }

    func testGetAccountBalance() {
        let expectation = self.expectation(description: MockData.getAccount)
        EthereumClient.shared.fetchBalance { result in
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

    func testSignMessage() {
        let signedMessage = EthereumClient.shared.sign(message: MockData.message)
        XCTAssertNotNil(signedMessage)
        XCTAssertEqual(signedMessage, MockData.signedMessage)
    }

    func testVerifyMessageVaild() {
        let customSignature = MockData.signedMessage.getCustomSignature()
        XCTAssertNotNil(customSignature)
        let result = EthereumClient.shared.verify(message: MockData.message,
                                                  signature: customSignature!)
        XCTAssertTrue(result)
    }

    func testVerifyMessageInvalid() {
        let customSignature = MockData.signedMessage.getCustomSignature()
        XCTAssertNotNil(customSignature)
        let result = EthereumClient.shared.verify(message: MockData.message2,
                                                  signature: customSignature!)
        XCTAssertFalse(result)
    }
}
