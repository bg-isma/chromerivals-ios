//
//  UIImageViewExtension.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 22/3/22.
//

import Foundation
import UIKit

extension UIImageView {

    func makeRounded() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.CRPrimaryColor().cgColor
    }
    
}
