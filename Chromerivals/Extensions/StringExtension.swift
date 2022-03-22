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
        let dateFormatter = DateFormatter() // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone.current
        let date = dateFormatter.date(from: self) ?? Date()
        return date
    }
    
    func toLocalDateString() -> String {
        let dateFormatter = DateFormatter() // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        dateFormatter.timeZone = TimeZone(identifier: "Europe/Paris")
        var date = dateFormatter.date(from: self) ?? Date()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let serverDateString = dateFormatter.string(from: date)
        
        dateFormatter.timeZone = TimeZone.current
        date = dateFormatter.date(from: serverDateString) ?? Date()
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([ .month, .day, .year, .hour, .minute], from: date)
        
        return String(format: "%02d-%02d-%02d %02d:%02d",
                      components.year ?? "yyyy",
                      components.month ?? "MM",
                      components.day ?? "dd",
                      components.hour ?? 00,
                      components.minute ?? 00
        )
    }
    
}
