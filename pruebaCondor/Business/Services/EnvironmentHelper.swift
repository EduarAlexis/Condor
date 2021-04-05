//
//  EnvironmentHelper.swift
//  XPI
//
//  Created by XPI on 8/4/20.
//  Copyright © 2020 Grupo Movalto. All rights reserved.
//

import Foundation

extension Helpers {
    
    class Environment {
        static let current: Environments = .dev
        
        static var currentUrl: String {
            switch current {
            case .dev: return "https://pokeapi.co/api/v2/"
            case .release: return "https://pokeapi.co/api/v2/"
            }
        }
    }

    enum Environments {
        case dev
        case release
    }
}
