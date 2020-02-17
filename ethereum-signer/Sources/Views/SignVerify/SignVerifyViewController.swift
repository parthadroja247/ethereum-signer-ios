//
//  SignVerifyViewController.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 16/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import UIKit

enum ControllerMode {
    case sign
    case verify

    var actionTitle: String {
        switch self {
        case .sign:
            return "Sign message"
        case .verify:
            return "Verify message"
        }
    }
}

class SignVerifyViewController: UIViewController {
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var signVerifyButton: UIButton!

    @IBAction func signVerifyAction(_: UIButton) {
        guard let text = messageTextField.text, !text.isEmpty else {
            // No text entered
            return
        }
        messageEntered(message: text)
    }

    private var contract: SignVerifyContract!
    var mode: ControllerMode = .sign

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func configureView() {
        configureContract()
        configureNavigationBar()
        configureTextField()
        configureUI()
    }

    private func configureContract() {
        contract = SignVerifyViewModel()
    }

    private func configureNavigationBar() {
        switch mode {
        case .sign:
            title = Constants.Title.sign
        case .verify:
            title = Constants.Title.verify
        }
    }

    private func configureTextField() {
        messageTextField.placeholder = Constants.Placeholder.yourMessage
        messageTextField.becomeFirstResponder()
        messageTextField.backgroundColor = .systemGray6
        messageTextField.autocorrectionType = .no
    }

    private func configureUI() {
        signVerifyButton.setTitle(mode.actionTitle, for: .normal)
    }

    private func messageEntered(message: String) {
        switch mode {
        case .sign:
            let result = contract.sign(message: message)
            guard result.0 else {
                return
            }
            let messageSignature = MessageSignature(message: message,
                                                    signature: result.1)
            signingSuccess(signedMessage: messageSignature)
        case .verify:
            contract.verify()
        }
    }

    private func signingSuccess(signedMessage: MessageSignature) {
        let signatureController = SignatureViewController.instantiateFrom(storyboard: .main)
        signatureController.signedMessage = signedMessage
        navigationController?.pushViewController(signatureController, animated: true)
    }
}
