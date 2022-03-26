//
//  Event.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 10/3/22.
//

import Foundation

struct Event: Codable, Equatable, Hashable {
    
    var id: UUID = UUID()
    
    var deployTime: String? = nil
    var ani: String? = nil
    var bcu: String? = nil
    var outpostName: String? = nil
    var influence: Double? = nil
    var mapsName: String? = nil
    var influenceType: Double? = nil
    var eventType: Double? = nil
    var maps: Array<Int>? = nil
    var startTime: String? = nil
    var endTime: String? = nil
    
    private enum CodingKeys: CodingKey {
        case deployTime
        case ani
        case bcu
        case outpostName
        case influence
        case mapsName
        case influenceType
        case eventType
        case maps
        case startTime
        case endTime
    }
    
    enum EventType {
        case UpcomingEvent
        case CurrentEvent
    }
    
    var type: EventType {
        if (self.outpostName != nil || self.ani != nil || self.bcu != nil) {
            return .UpcomingEvent
        } else {
            return .CurrentEvent
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
