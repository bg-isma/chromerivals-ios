//
//  UILabelExtension.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 17/3/22.
//

import Foundation
import UIKit

extension UILabel: CRViewComponent {
    
    var componentView: UIView {
        self
    }

    var contentSize: CGSize {
        CGSize(width: 0, height: 24)
    }
    
    var insets: UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 20, bottom: 5, right: 0)
    }
    
    var height: CGFloat {
        contentSize.height + insets.bottom + insets.top
    }

    func toChromeRivalsHeader(text: String, width: CGFloat) -> UILabel {
        let upcomingEventFont = UIFont(name: "Nunito Sans Bold", size: 20)
        self.font = upcomingEventFont
        self.textColor = .black
        self.text = text
        self.backgroundColor = .white
        self.sizeToFit()
        self.frame.size.width = self.frame.width + insets.left
        self.frame = self.frame.inset(by: insets)
        return self
    }
    
}
