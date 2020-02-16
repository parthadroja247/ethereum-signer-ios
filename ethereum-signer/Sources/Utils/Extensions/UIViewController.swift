//
//  UIViewController.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 16/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }

    static func instantiateFrom(storyboard: Storyboard) -> Self {
        return storyboard.viewController(viewControllerClass: self)
    }
}
