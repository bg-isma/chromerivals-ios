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
    var fixes: Array<Fix>? = nil
    var items: Array<Item>? = nil
    var monsters: Array<Monster>? = nil
}

struct PediaResponse: Codable {
    var result: [String: String]? = nil
}

struct ItemResponse: Codable {
    var result: Item? = nil
}
struct MonsterResponse: Codable {
    var result: Monster? = nil
}
struct FixResponse: Codable {
    var result: Fix? = nil
}
