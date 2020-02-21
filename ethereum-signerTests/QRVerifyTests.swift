//
//  QRVerifyTests.swift
//  ethereum-signerTests
//
//  Created by Parth Adroja on 22/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

@testable import ethereum_signer
import XCTest

class QRVerifyTests: XCTestCase {
    struct MockData {
        static let validPrivateKey = "9857D8DCDE92863801FD47DD1CBEF610194748C78A12D99D5D97F478CE3C5271"
        static let message = "EthereumSigner"
        static let message2 = "HelloWorld"
        // swiftlint:disable line_length
        static let signedMessage = "eyJyQnl0ZXMiOlsxMDEsNjAsMjEzLDEzOSwxNzksMTM5LDE2NywxMjUsMTE2LDIyMCwxNjQsMTk0LDE2NCwxNDUsMTQyLDIzOSwxNzUsMTM4LDQzLDIxMywyNDgsMjAzLDIxLDI0Niw3OCwxMCwxODUsMjUwLDc2LDk3LDksMjI0XSwidkJ5dGVzIjoxLCJzQnl0ZXMiOls2NSw1OCwzMSwxMDksNSwyNTUsMjA1LDgyLDIwNCw5NSwxNzcsMjQ0LDQ2LDE3MSw2OCwyMSwxNCw3NywzNSwxMjksMTg1LDE4OCwyMzAsMjExLDIxNSwyMjAsNzgsMTY0LDEwNiwxOTksMTQyLDQ3XX0="
        // swiftlint:enable line_length
    }

    private var contract: QRScannerViewModel!

    override func setUp() {
        configureClient()
        contract = QRScannerViewModel()
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

    func testVerifyMessageVaild() {
        let customSignature = MockData.signedMessage.getCustomSignature()
        XCTAssertNotNil(customSignature)
        let result = contract.verify(message: MockData.message,
                                     signature: customSignature!)
        XCTAssertTrue(result)
    }

    func testVerifyMessageInvalid() {
        let customSignature = MockData.signedMessage.getCustomSignature()
        XCTAssertNotNil(customSignature)
        let result = contract.verify(message: MockData.message2,
                                     signature: customSignature!)
        XCTAssertFalse(result)
    }
}
