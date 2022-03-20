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
    
}
