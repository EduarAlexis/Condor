//
//  FirstPokemonDetails.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import Foundation

struct FirstPokemonDetails: Codable {
    let color, growthRate: Color
    let id: Int
    let isLegendary, isMythical: Bool
    let name: String
    let pokedexNumbers: [PokedexNumber]
    let varieties: [Variety]

    enum CodingKeys: String, CodingKey {
        case color = "color"
        case growthRate = "growth_rate"
        case id = "id"
        case isLegendary = "is_legendary"
        case isMythical = "is_mythical"
        case name = "name"
        case pokedexNumbers = "pokedex_numbers"
        case varieties = "varieties"
    }
}

struct Color: Codable {
    let name: String
    let url: String
}

struct PokedexNumber: Codable {
    let entryNumber: Int
    let pokedex: Color

    enum CodingKeys: String, CodingKey {
        case entryNumber = "entry_number"
        case pokedex
    }
}

struct Variety: Codable {
    let isDefault: Bool
    let pokemon: Color

    enum CodingKeys: String, CodingKey {
        case isDefault = "is_default"
        case pokemon
    }
}
