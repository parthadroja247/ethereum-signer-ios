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

    @IBAction func signVerifyAction(_: UIButton) {}

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
        messageTextField.delegate = self
        messageTextField.autocorrectionType = .no
    }

    private func configureUI() {
        signVerifyButton.setTitle(mode.actionTitle, for: .normal)
    }
}

extension SignVerifyViewController: UITextFieldDelegate {}