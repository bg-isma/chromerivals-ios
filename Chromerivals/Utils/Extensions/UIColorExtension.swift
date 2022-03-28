//
//  UIColorExtension.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 10/3/22.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hex: String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init (
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class func CRPrimaryColor() -> UIColor {
        return UIColor(hex: "#006488")
    }
    
    class func CRSecundaryColor() -> UIColor {
        return UIColor(hex: "#886A00")
    }
    
    class func CRGrayColor() -> UIColor {
        return UIColor(hex: "#F4F4F4")
    }
    
    class func CRTextDescription() -> UIColor {
        return UIColor(hex: "9D9D9D")
    }
}
