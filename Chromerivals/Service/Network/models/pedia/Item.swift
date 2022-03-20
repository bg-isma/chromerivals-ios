//
//  Item.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 17/3/22.
//

import Foundation

struct Item: PediaElement, Codable  {
    var itemCode: ItemCode? = nil
    var name: String? = nil
    var iconId: Double? = nil
    var level: Int? = nil
    var kind: Int? = nil
    var gear: Int? = nil
    var drops: Array<DropFromItem>? = nil
    var usedFor: Array<UsedForItem>? = nil
    var mixingElements: Array<MixingElementsItem>? = nil
    var itemInfo: Array<String>? = nil
    var count: Int? = nil
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
    var referenceMonster: Monster? = nil
    var minimumCount: Int? = nil
    var maximumCount: Int? = nil
    var dropProbability: Double? = nil
}

struct MixingElementsListItem: Codable  {
    var item: Item? = nil
    var count: Int? = nil
}

struct MixingElementsItem: ExpandableListItem, Codable  {
    var cost: Int? = nil
    var chance: Int? = nil
    var elements: Array<MixingElementsListItem>? = nil
}
