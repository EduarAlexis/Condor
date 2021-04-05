//
//  Util.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import Foundation
import UIKit

class Util {
    
    private static let dateFormatter = DateFormatter()
    
    static func setImage(urlImage: String, imageView: UIImageView, contentMode: UIView.ContentMode = .scaleAspectFill) -> UIImageView {
        if urlImage != "", let url = URL(string: urlImage) {
            imageView.load(from: url, contentMode: .scaleAspectFill) { success in
                if !success { imageView.image = .pokemon }
            }
        } else {
            imageView.image = .pokemon
        }
        imageView.contentMode = contentMode
        return imageView
    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
