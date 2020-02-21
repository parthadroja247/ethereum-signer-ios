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

    func getCustomSignature() -> CustomSignature? {
        guard let messageData = Data(base64Encoded: self) else {
            return nil
        }
        do {
            let customSignature = try JSONDecoder().decode(CustomSignature.self,
                                                           from: messageData)
            return customSignature
        } catch {
            return nil
        }
    }
}
