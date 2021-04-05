//
//  GenerationViewModel.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import Foundation
import SwiftSpinner

class GenerationsViewModel {
    var navigator: GenerationsNavigator?

    func inicializar(dispatchGroup: DispatchGroup) {
        getAllGenerations(dispatchGroup: dispatchGroup)
    }
    
    func getAllGenerations(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        SwiftSpinner.show("Loading ...")
        let service = GenerationsService(baseUrl: Helpers.Environment.currentUrl)
        service.getAllGenerationsFrom(endPoint: "generation")
        service.completionHandler { [weak self] (generations, status, message) in
            SwiftSpinner.hide()
            if status {
                dispatchGroup.leave()
                guard let self = self else {return}
                guard let _generations = generations else {return}
                self.navigator?.getGenerations(generations: _generations)
            } else {
                dispatchGroup.leave()
                self?.navigator?.showError(error: message)
            }
        }
    }
}
