//
//  SearchResponse.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 10/3/22.
//

import Foundation

struct SearchResponse: Codable {
    var result: SearchResponseResult? = nil
}

struct SearchResponseResult: Codable {
    var fixes: Array<PediaElement>? = nil
    var items: Array<PediaElement>? = nil
    var monsters: Array<PediaElement>? = nil
}

/*
struct PediaResponse: Codable {
    var result: [String: String]? = nil
}
 */

struct PediaResponse: Codable {
    var result: PediaElement? = nil
}
