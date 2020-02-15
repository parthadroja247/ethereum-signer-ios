//
//  EnvironmentConfiguration.swift
//  ethereum-signer
//
//  Created by Parth Adroja on 15/02/20.
//  Copyright © 2020 Parth Adroja. All rights reserved.
//

import Foundation

struct EnvironmentConfiguration {
    lazy var current: Environment = {
        guard let configuration = Bundle.main.object(forInfoDictionaryKey:
            "Configuration") as? String,
            let environment = Environment(rawValue: configuration) else {
            return .production
        }
        return environment
    }()
}
