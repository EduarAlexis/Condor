//
//  AlertHelper.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import Foundation
import UIKit

extension Helpers {
    
    class Alert {
        
        private init() {}
        
        static func dialog(_ vc: UIViewController) -> DialogBuilder {
            return DialogBuilder(vc)
        }
        
        class DialogBuilder {
            
            private let vc: UIViewController
            
            private var title: String? = "pokemons"
            private var message: String? = nil
            private var actions: [UIAlertAction] = []
            private var style: UIAlertController.Style = .alert
            
            fileprivate init(_ vc: UIViewController) {
                self.vc = vc
            }
            
            func title(_ title: String?) -> DialogBuilder {
                self.title = title
                return self
            }
            
            func message(_ message: String?) -> DialogBuilder {
                self.message = message
                return self
            }
            
            func action(text: String?, style: UIAlertAction.Style = .default, _ handler: (() -> Void)? = nil) -> DialogBuilder {
                actions.append(UIAlertAction(title: text, style: style) { _ in
                    handler?()
                })
                return self
            }
            
            func style(_ style: UIAlertController.Style) -> DialogBuilder {
                self.style = style
                return self
            }
            
            func show() {
                let alert = UIAlertController(title: title, message: message, preferredStyle: style)
                alert.view.tintColor = UIColor.yellow
                if actions.count == 0 {
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                } else {
                    for action in actions {
                        alert.addAction(action)
                    }
                }
                
                vc.present(alert, animated: true, completion: nil)
            }
        }
    }
}
