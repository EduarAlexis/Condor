//
//  PokemonDetails.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import Foundation

class PokemonDetails {
    var firstDetail: FirstPokemonDetails
    var secondDetail: SecondPokemonDetails
    
    init(firstDetail: FirstPokemonDetails, secondDetail: SecondPokemonDetails) {
        self.firstDetail = firstDetail
        self.secondDetail = secondDetail
    }
}
