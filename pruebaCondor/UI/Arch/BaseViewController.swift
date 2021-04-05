//
//  BaseViewController.swift
//  Moviva
//
//  Created by XPI on 6/26/20.
//  Copyright © 2020 Grupo Movalto. All rights reserved.
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
