//
//  UITextFieldExtension.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 17/3/22.
//

import Foundation
import UIKit

extension UITextField {
    
    func toChromerivalsTextField() {
        self.textInputView.layer.borderWidth = 0
        self.textInputView.tintColor = UIColor.CRPrimaryColor()
        self.borderStyle = .none
        self.backgroundColor = UIColor.CRGrayColor()
        self.tintColor = UIColor.CRPrimaryColor()
        self.font = self.font?.withSize(20)
        self.layer.borderWidth = 0
        self.textColor = UIColor.CRPrimaryColor()
        self.attributedPlaceholder = NSAttributedString(string: "Search...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.CRPrimaryColor()])
    }
    
}
