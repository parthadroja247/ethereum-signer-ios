//
//  AccountViewController.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 16/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    private var contract: AccountContract!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(contract.getAccountAddress())
        print(contract.getAccountBalance())
    }

    private func configureView() {
        configureContract()
        configureNavigationBar()
    }

    private func configureContract() {
        contract = AccountViewModel()
    }

    private func configureNavigationBar() {
        title = Constants.Title.account
        navigationItem.setHidesBackButton(true, animated: true)
    }
}
