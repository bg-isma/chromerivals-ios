//
//  CurrentEvent.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 10/3/22.
//

import Foundation

struct CurrentEvent: Event, Codable {
    var mapsName: String? = nil
    var influenceType: Double? = nil
    var eventType: Double? = nil
    var maps: Array<Int>? = nil
    var startTime: String? = nil
    var endTime: String? = nil
    var mapName: String? = nil
}
