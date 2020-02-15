//
//  Environment.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 15/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import Foundation

enum Environment: String {
    case dev = "DEV"
    case sit = "SIT"
    case uat = "UAT"
    case production = "PRODUCTION"
    
    var environmentDescription: String {
        switch self {
        case .dev:
            return "Development"
        case .sit:
            return "System Intergration Test"
        case .uat:
            return "User Acceptance Test"
        case .production:
            return "Production"
        }
    }
}
