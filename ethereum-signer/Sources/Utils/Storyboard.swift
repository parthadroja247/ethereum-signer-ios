//
//  Storyboard.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 16/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case main = "Main"

    var instance: UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: .main)
    }

    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        // swiftlint:disable force_cast
        return instance.instantiateViewController(identifier: storyboardID) as! T
        // swiftlint:enable force_cast
    }
}
