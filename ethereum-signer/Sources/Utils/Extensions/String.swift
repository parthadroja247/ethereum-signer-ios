//
//  String.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 17/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func generateQRCode() -> UIImage? {
        let data = self.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
}
