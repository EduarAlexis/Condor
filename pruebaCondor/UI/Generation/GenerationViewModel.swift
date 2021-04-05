//
//  GenerationViewModel.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import Foundation
import SwiftSpinner

class GenerationViewModel {
    var navigator: GenerationNavigator?
    func inicializar(dispatchGroup: DispatchGroup, idGeneration: String?) {
        getGeneration(dispatchGroup: dispatchGroup, generationId: idGeneration!)
    }
    
    func getGeneration(dispatchGroup: DispatchGroup, generationId: String) {
        dispatchGroup.enter()
        SwiftSpinner.show("Loading generation")
        let service = GenerationService(baseUrl: Helpers.Environment.currentUrl)
        service.getGenerationsFrom(endPoint: "generation/\(generationId)")
        service.completionHandler { [weak self] (generation, status, message) in
            dispatchGroup.leave()
            SwiftSpinner.hide()
            if status {
                guard self != nil else {return}
                guard let _generation = generation else {return}
                self?.navigator?.getGeneration(generation: _generation)
            } else {
                self?.navigator?.showError(error: message)
            }
        }
    }
}
