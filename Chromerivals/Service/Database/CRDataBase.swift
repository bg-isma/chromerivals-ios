//
//  CRDataBase.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 17/3/22.
//

import Foundation
import RealmSwift

class CRDataBase {
    var localRealm: Realm? = {
        do {
            return try Realm()
        } catch { return nil }
    }()
    
    func deleteAllEvents()  {
        do {
            guard let realm = self.localRealm else { return }
            try realm.write {
                realm.deleteAll()
            }
        } catch {}
    }
    
    func addEvent(event: UpcomingEventDB) {
        do {
            guard let realm = self.localRealm else { return }
            try realm.write {
                realm.add(event)
            }
        } catch {}
    }
    
    func getAllEvents() -> [Event] {
        guard let realm = self.localRealm else { return [] }
        var events: [Event] = []
        for event in realm.objects(UpcomingEventDB.self).enumerated() {
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: event, requiringSecureCoding: false)
                let result = try JSONDecoder().decode(Event.self, from: data)
                events.append(result)
            } catch {}
        }
        return events
    }
    
}
