//
//  SignatureViewController.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 17/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import UIKit

class SignatureViewController: UIViewController {
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var qrCodeImageView: UIImageView!

    var signedMessage: MessageSignature?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func configureView() {
        configureNavigationBar()
        configureUI()
    }

    private func configureNavigationBar() {
        title = Constants.Title.signature
    }

    private func configureUI() {
        guard let signedMessage = signedMessage else {
            messageLabel.text = Constants.Error.generic
            return
        }

        messageLabel.text = "Message: \(signedMessage.message)"
        if let qrImage = signedMessage.signature.generateQRCode() {
            qrCodeImageView.image = qrImage
        }
    }
}
