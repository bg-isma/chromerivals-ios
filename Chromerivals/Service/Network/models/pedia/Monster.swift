//
//  Monster.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 17/3/22.
//

import Foundation

struct Monster: PediaElement, Codable {
    var monsterCode: MonsterCode? = nil
    var iconId: Double? = nil
    var level: Int? = nil
    var name: String? = nil
    var hp: Double? = nil
    var speed: Double? = nil
    var range: Double? = nil
    var recoveryValue: Double? = nil
    var recoveryTime: Double? = nil
    var experience: Double? = nil
    var tier: Int? = nil
    var drop: Array<DropItem>? = nil
}

struct MonsterCode: Codable  {
    var id: Double? = nil
    var idString: String? = nil
}

struct DropItem: ExpandableListItem, Codable  {
    var referenceItem: Item? = nil
    var minimumCount: Int? = nil
    var maximumCount: Int? = nil
    var dropProbability: Double? = nil
}
