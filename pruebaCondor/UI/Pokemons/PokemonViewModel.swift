//
//  PokemonViewModel.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import Foundation
import SwiftSpinner

class PokemonViewModel {
    var urlPokemon: String?
    var navigator: PokemonNavigator?
    func inicializar(dispatchGroup: DispatchGroup) {
        getFirstPokemonDetail(dispatchGroup: dispatchGroup)
    }
    
    func getFirstPokemonDetail(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        SwiftSpinner.show("Loading pokemon detail")
        let service = PokemonDetailsService(baseUrl: Helpers.Environment.currentUrl)
        
        let start1 = urlPokemon!.index(urlPokemon!.startIndex, offsetBy: 26)
        let end1 = urlPokemon!.index(urlPokemon!.endIndex, offsetBy: 0)
        let numPokemon = urlPokemon![start1 ..< end1]
        let start2 = numPokemon.index(numPokemon.startIndex, offsetBy:16)
        let end2 = numPokemon.index(numPokemon.endIndex, offsetBy:-1)
        let pokemonId = numPokemon[start2 ..< end2]
        
        service.getFirstDetailPokemonFrom(endPoint: "\(numPokemon)")
        service.firstCompletionHandler { [weak self] (firstDetail, status, message) in
            dispatchGroup.leave()
            if status {
                guard self != nil else {return}
                guard let _firstDetail = firstDetail else {return}
                self?.getSecondPokemonDetail(dispatchGroup: dispatchGroup, pokemonId: "\(pokemonId)", firstDetail: _firstDetail)
            } else {
                SwiftSpinner.hide()
                self?.navigator?.showError(error: message)
            }
        }
    }
    
    func getSecondPokemonDetail(dispatchGroup: DispatchGroup, pokemonId: String,  firstDetail: FirstPokemonDetails?) {
        dispatchGroup.enter()
        let service = PokemonDetailsService(baseUrl: Helpers.Environment.currentUrl)
        service.getSecondDetailPokemonFrom(endPoint: "pokemon/\(pokemonId)")
        service.secondCompletionHandler { [weak self] (secondDetail, status, message) in
            dispatchGroup.leave()
            SwiftSpinner.hide()
            if status {
                guard self != nil else {return}
                guard let _secondDetail = secondDetail else {return}
                self?.navigator?.showDetailsPokemon(firstDetail: firstDetail, secondDetail: _secondDetail)
            } else {
                self?.navigator?.showError(error: message)
            }
        }
    }
}
