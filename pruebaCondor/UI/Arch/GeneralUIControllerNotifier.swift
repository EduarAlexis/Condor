//
//  GeneralUIControllerNotifier.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import Foundation
import UIKit
import SwiftSpinner

protocol GeneralUIControllerNotifier {
    
    func showError(error: String?)
    
    func showMessage(message: String?)
    
    func showLoading(message: String?)
    
    func hideLoading()
}

extension UIViewController: GeneralUIControllerNotifier {
    
    var isDarkMode: Bool {
        if #available(iOS 13.0, *) {
            return self.traitCollection.userInterfaceStyle == .dark
        }
        return false
    }
    
    var currentFirstResponder: UIResponder? {
        return UIResponder.currentFirstResponder
    }
    
    var generalUINotifier: GeneralUIControllerNotifier {
        return self
    }
    
    func showError(error: String?) {
        Helpers.Alert.dialog(self)
            .title("Error")
            .message(error)
            .show()
    }
    
    func showMessage(message: String?) {
        Helpers.Alert.dialog(self)
            .message(message)
            .show()
    }

    func showLoading(message: String? = nil) {
        SwiftSpinner.shared.innerColor = .yellow
        SwiftSpinner.shared.outerColor = .darkGray
        SwiftSpinner.show(message ?? "Cargando...")
    }
    
    func hideLoading() {
        SwiftSpinner.hide()
    }
}
