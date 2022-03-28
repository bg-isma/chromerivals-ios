//
//  UITabBarExtension.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 22/3/22.
//

import Foundation
import UIKit

extension UITabBar {
    
    func toCRTabBar() {
        self.tintColor = UIColor.CRPrimaryColor()
        self.barTintColor = UIColor.CRGrayColor()
        self.backgroundColor = UIColor.CRGrayColor()
    }
    
}
