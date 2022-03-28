//
//  DateExtension.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 22/3/22.
//

import Foundation
import UIKit

extension Date {
    func countDownString(until nowDate: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.minute, .second], from: self, to: nowDate)
        return String(format: "%02d:%02d", components.minute ?? 00, components.second ?? 00)
    }
}
