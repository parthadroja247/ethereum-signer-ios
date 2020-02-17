//
//  AccountViewController.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 16/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    @IBOutlet var addressPlaceholderLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var balancePlaceholderLabel: UILabel!
    @IBOutlet var balanceLabel: UILabel!

    @IBAction func signAction(_: UIButton) {
        navigateToSignVerify(controllerMode: .sign)
    }

    @IBAction func verifyAction(_: UIButton) {
        navigateToSignVerify(controllerMode: .verify)
    }

    private var contract: AccountContract!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        fetchBalance()
    }

    private func configureView() {
        configureContract()
        configureNavigationBar()
        configureLabels()
    }

    private func configureContract() {
        contract = AccountViewModel()
    }

    private func configureNavigationBar() {
        title = Constants.Title.account
        navigationItem.setHidesBackButton(true, animated: true)
    }

    private func configureLabels() {
        addressPlaceholderLabel.text = Constants.Placeholder.address
        balancePlaceholderLabel.text = Constants.Placeholder.balance
        addressLabel.text = contract.getAccountAddress()
        addressLabel.lineBreakMode = .byTruncatingMiddle
    }

    private func fetchBalance() {
        contract.getAccountBalance { response in
            switch response {
            case let .success(balance):
                self.updateUI(balance: balance)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    private func updateUI(balance: Double) {
        DispatchQueue.main.async {
            let balanceString = "\(balance) Ether"
            self.balanceLabel.text = balanceString
        }
    }

    private func navigateToSignVerify(controllerMode: ControllerMode) {
        let controller = SignVerifyViewController.instantiateFrom(storyboard: .main)
        controller.mode = controllerMode
        navigationController?.pushViewController(controller, animated: true)
    }
}
