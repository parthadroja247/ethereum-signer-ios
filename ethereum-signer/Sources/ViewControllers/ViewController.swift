//
//  ViewController.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 15/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var config = EnvironmentConfiguration()
        print(config.current.environmentDescription)
    }


}

