//
//  StringExtension.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 17/3/22.
//

import Foundation

extension String {
    
    mutating func deleteStrangeCharacters() -> String {
        let charactersToDelete = "\\o,\\y,\\c,\\g,\\e,\\r,\\e,\\m,\\u,\\I,\\r,\\l,\\i,\\L,\\w,\\W".split(separator: ",")
        for letter in charactersToDelete.enumerated() {
            self = self.replacingOccurrences(of: "\(letter.element)", with: "", options: .literal, range: nil)
        }
        return self
    }
    
    func toLocalDate() -> Date {
        return Constants.dateFormaterToLocalTimeZone.date(from: self) ?? Date()
    }
    
    func toLocalDateString() -> String {
        var date = Constants.dateFormaterToServerTimeZoneWithoutTimeZoneString.date(from: self) ?? Date()
        let serverDateString = Constants.dateFormaterToServerTimeZoneWithTimeZoneString.string(from: date)
        date = Constants.dateFormaterToLocalTimeZone.date(from: serverDateString) ?? Date()
        let components = Constants.calendar.dateComponents([ .month, .day, .year, .hour, .minute], from: date)
        return String(format: "%02d-%02d-%02d %02d:%02d",
                      components.year ?? "yyyy",
                      components.month ?? "MM",
                      components.day ?? "dd",
                      components.hour ?? 00,
                      components.minute ?? 00
        )
    }
    
}
