//
//  PediaElement.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 14/3/22.
//

import Foundation

struct PediaElement: Codable, Equatable, Hashable {
    
    var id: UUID = UUID()
    
    var name: String? = nil
    var iconId: Double? = nil
    var monsterCode: MonsterCode? = nil
    var level: Int? = nil
    var hp: Double? = nil
    var speed: Double? = nil
    var range: Double? = nil
    var recoveryValue: Double? = nil
    var recoveryTime: Double? = nil
    var experience: Double? = nil
    var tier: Int? = nil
    var drop: Array<DropItem>? = nil
    var itemCode: ItemCode? = nil
    var fixCode: FixCode? = nil
    var kind: Int? = nil
    var gear: Int? = nil
    var drops: Array<DropFromItem>? = nil
    var usedFor: Array<UsedForItem>? = nil
    var mixingElements: Array<MixingElementsItem>? = nil
    var itemInfo: Array<String>? = nil
    var count: Int? = nil
    
    private enum CodingKeys: CodingKey {
        case name
        case iconId
        case monsterCode
        case level
        case hp
        case speed
        case range
        case recoveryValue
        case recoveryTime
        case experience
        case tier
        case drop
        case itemCode
        case fixCode
        case kind
        case gear
        case drops
        case usedFor
        case mixingElements
        case itemInfo
        case count
    }
    
    var type: PediaElementType {
        if (fixCode != nil) { return .Fixe }
        if (monsterCode != nil) { return .Monster }
        return .Item
    }
    
    enum PediaElementType {
        case Monster
        case Item
        case Fixe
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: PediaElement, rhs: PediaElement) -> Bool {
        lhs.id == rhs.id
    }
    
}

struct MonsterCode: Codable  {
    var id: Double? = nil
    var idString: String? = nil
}

struct FixCode: Codable  {
    var id: Double? = nil
    var idString: String? = nil
}

struct DropItem: ExpandableListItem, Codable  {
    var referenceItem: PediaElement? = nil
    var minimumCount: Int? = nil
    var maximumCount: Int? = nil
    var dropProbability: Double? = nil
}

struct ItemCode: Codable  {
    var id: Double? = nil
    var idString: String? = nil
}

struct UsedForItem: ExpandableListItem, Codable  {
    var itemCode: ItemCode? = nil
    var name: String? = nil
    var iconId: Double? = nil
    var level: Int? = nil
    var kind: Int? = nil
    var gear: Int? = nil
}

struct DropFromItem: ExpandableListItem, Codable  {
    var referenceMonster: PediaElement? = nil
    var minimumCount: Int? = nil
    var maximumCount: Int? = nil
    var dropProbability: Double? = nil
}

struct MixingElementsListItem: Codable  {
    var item: PediaElement? = nil
    var count: Int? = nil
}

struct MixingElementsItem: ExpandableListItem, Codable  {
    var cost: Int? = nil
    var chance: Int? = nil
    var elements: Array<MixingElementsListItem>? = nil
}

