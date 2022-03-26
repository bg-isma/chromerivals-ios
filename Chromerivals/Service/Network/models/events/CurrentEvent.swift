//
//  CurrentEvent.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 10/3/22.
//

import Foundation

struct CurrentEvent: Event, Codable, Hashable {

    
    func hash(into hasher: inout Hasher) {
        hasher.combine("")
    }
    
}
