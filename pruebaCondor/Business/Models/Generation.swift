//
//  Generation.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import Foundation

struct Generation: Codable {
    var id: Int
    var mainRegion: MainRegion
    var moves: [MainRegion]
    var name: String
    var names: [Name]
    var pokemonSpecies, types, versionGroups: [MainRegion]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case mainRegion = "main_region"
        case moves = "moves"
        case name = "name"
        case names = "names"
        case pokemonSpecies = "pokemon_species"
        case types = "types"
        case versionGroups = "version_groups"
    }
}

// MARK: - MainRegion
struct MainRegion: Codable {
    let name: String
    let url: String
}

// MARK: - Name
struct Name: Codable {
    let language: MainRegion
    let name: String
}
