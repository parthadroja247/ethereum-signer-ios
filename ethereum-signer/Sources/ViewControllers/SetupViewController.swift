//
//  SetupViewController.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 16/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import UIKit
import Web3

class SetupViewController: UIViewController {
    @IBOutlet var privateKeyTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func configureView() {
        configureNavigationBar()
        configurePrivateKeyTextField()
    }

    private func configureNavigationBar() {
        title = Constants.Title.setup
        navigationItem.setHidesBackButton(true, animated: true)
    }

    private func configurePrivateKeyTextField() {
        privateKeyTextField.placeholder = Constants.Placeholder.privateKey
        privateKeyTextField.becomeFirstResponder()
        privateKeyTextField.backgroundColor = .systemGray6
        privateKeyTextField.delegate = self
    }

    private func privateKeyEntered(key: String) {
        print("KEY == \(key)")
    }
}

extension SetupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            // No text entered
            return false
        }
        privateKeyEntered(key: text)
        return true
    }
}
