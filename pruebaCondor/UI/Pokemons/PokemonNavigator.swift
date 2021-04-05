//
//  PokemonNavigator.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import Foundation

protocol PokemonNavigator: BaseNavigator {
    func showDetailsPokemon(firstDetail: FirstPokemonDetails?, secondDetail: SecondPokemonDetails?)
    func showError(error: String)
}
