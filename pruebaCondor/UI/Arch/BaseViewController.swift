//
//  BaseViewController.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    var isForeground = true
    
    override func viewDidAppear(_ animated: Bool) {
        isForeground = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        isForeground = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
         return .lightContent
    }
}

class BaseNavigationController: UINavigationController {
    
    var isForeground = true
    
    override func viewDidAppear(_ animated: Bool) {
        isForeground = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        isForeground = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
         return .lightContent
    }
}
