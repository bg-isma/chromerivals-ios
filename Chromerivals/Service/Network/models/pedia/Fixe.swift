//
//  Fixe.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 17/3/22.
//

import Foundation

struct Fix: PediaElement, Codable  {
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
