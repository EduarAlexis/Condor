//
//  UIExtensions.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import Foundation
import UIKit
import PINRemoteImage

extension UIResponder {
    
    private static weak var _currentFirstResponder: UIResponder?
    
    static var currentFirstResponder: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return _currentFirstResponder
    }
    
    @objc func findFirstResponder(_ sender: Any) {
        UIResponder._currentFirstResponder = self
    }
}

extension UIButton {

    func setBackgroundColor(_ color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}

extension UIView {
    func addShadowView(width:CGFloat=0.2, height:CGFloat=0.2, Opacidade:Float=0.7, maskToBounds:Bool=false, radius:CGFloat=0.5){
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = Opacidade
        self.layer.masksToBounds = maskToBounds
    }
    
    func hideWithAnimation(hidden: Bool) {
        UIView.transition(with: self, duration: 0.4, options: .transitionCrossDissolve, animations: {
            self.isHidden = hidden
        })
    }
    
    func borderView(radius: CGFloat) {
        let color:UIColor = UIColor.gray
        let roundView:UIView = self
        roundView.layer.cornerRadius = CGFloat(radius)
        roundView.layer.borderWidth = 0.2
        roundView.layer.borderColor = color.cgColor
        roundView.clipsToBounds = true
    }
    
    func circleRounded() {
        self.layer.borderWidth = 0
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.layer.shadowColor = UIColor.lightGray.cgColor
    }
}

extension UIImageView {
    func load(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill, completion: ((_ success: Bool) -> ())? = nil) {
        contentMode = mode
        self.pin_setImage(from: url) { result in
            completion?(result.error == nil)
            self.contentMode = mode
        }
    }
    
    func load(from link: String?, contentMode mode: UIView.ContentMode = .scaleAspectFill, completion: ((_ success: Bool) -> ())? = nil) {
        guard link != nil, let url = URL(string: link!) else {
            completion?(false)
            return
        }
        load(from: url, contentMode: mode, completion: completion)
    }
}
