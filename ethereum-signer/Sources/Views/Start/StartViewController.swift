//
//  StartViewController.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 15/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigateToSetup()
    }

    func navigateToSetup() {
        let setupController = SetupViewController.instantiateFrom(storyboard: .main)
        navigationController?.pushViewController(setupController, animated: true)
    }
}
