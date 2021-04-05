//
//  EnvironmentHelper.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
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
