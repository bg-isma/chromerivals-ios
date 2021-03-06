//
//  EventResponse.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 10/3/22.
//

import Foundation

struct MothershipsResponse: Codable, NetworkResponse {
    var result: MothershipsResponseResult? = nil
}

struct MothershipsResponseResult: Codable {
    var ani: String? = nil
    var bcu: String? = nil
}

struct EventResponse: Codable, NetworkResponse {
    var result: Array<Event>? = nil
}
