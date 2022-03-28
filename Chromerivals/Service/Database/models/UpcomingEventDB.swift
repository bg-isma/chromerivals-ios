//
//  UpcomingEventDB.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 17/3/22.
//

import Foundation
import RealmSwift

class UpcomingEventDB: Object, Codable {
    @Persisted var deployTime: String? = nil
    @Persisted var ani: String? = nil
    @Persisted var bcu: String? = nil
    @Persisted var outpostName: String? = nil
    @Persisted var influence: Double? = nil
    
    convenience init(
        deployTime: String? = nil,
        ani: String? = nil,
        bcu: String? = nil,
        outpostName: String? = nil,
        influence: Double? = nil
    ) {
        self.init()
        self.deployTime = deployTime
        self.ani = ani
        self.bcu = bcu
        self.outpostName = outpostName
        self.influence = influence
    }
}
