//
//  CRDataBase.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 17/3/22.
//

import Foundation
import RealmSwift

class CRDataBase {
    lazy var localRealm = try! Realm()
    
    func deleteAllEvents()  {
        try! localRealm.write {
            localRealm.deleteAll()
        }
    }
    
    func addEvent(event: UpcomingEventDB) {
        try! localRealm.write {
            localRealm.add(event)
        }
    }
    
    func getAllEvents() -> [Event] {
        var events: [Event] = []
        for event in localRealm.objects(UpcomingEventDB.self).enumerated() {
            let data = (try? NSKeyedArchiver.archivedData(withRootObject: event, requiringSecureCoding: false)) ?? Data()
            let result = try! JSONDecoder().decode(Event.self, from: data)
            events.append(result)
        }
        return events
    }
}
