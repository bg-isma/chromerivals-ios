//
//  UpcomingEvent.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 10/3/22.
//

import Foundation

struct UpcomingEvent: Event, Codable, Equatable {
    var deployTime: String? = nil
    var ani: String? = nil
    var bcu: String? = nil
    var outpostName: String? = nil
    var influence: Double? = nil
}


