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

    private var contract: SetupContract!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        privateKeyTextField.resignFirstResponder()
    }

    private func configureView() {
        configureContract()
        configureNavigationBar()
        configurePrivateKeyTextField()
    }

    private func configureContract() {
        contract = SetupViewModel()
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
        privateKeyTextField.autocorrectionType = .no
    }

    private func privateKeyEntered(key: String) {
        let result = contract.validatePrivateKey(key: key)
        if result.0 != nil {
            privateKeyValidated(key: result.0!)
        }
    }

    private func privateKeyValidated(key: EthereumPrivateKey) {
        contract.configureEthereumClient(key: key)
        navigateToAccounts()
    }

    private func navigateToAccounts() {}
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
