//
//  GenerationNavigator.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import Foundation

protocol GenerationsNavigator: BaseNavigator {
    func getGenerations(generations: Generations?)
    func showError(error: String)
}
