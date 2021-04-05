//
//  GenerationNavigator.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import Foundation

protocol GenerationNavigator: BaseNavigator {
    func getGeneration(generation: Generation?)
    func showError(error: String)
}
