//
//  EventRepository.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 24/3/22.
//

import Foundation
import UIKit

extension Array where Element == Event {
    
    func filterByType(withType upcomingEventType: FilterType) -> [Event] {
        let outpostCondition = { (event: Event) -> Bool in (event.outpostName != nil) }
        let mothershipsCondition = { (event: Event) -> Bool in (event.ani != nil) || (event.bcu != nil) }
        
        if (upcomingEventType == .Outpost) { return self.filter({ outpostCondition($0) }) }
        if (upcomingEventType == .Motherships) { return self.filter({ mothershipsCondition($0) }) }
        return self
    }
    
}

extension Array where Element == PediaElement {
    
    func filterByType(withType pediaElementType: FilterType) -> [PediaElement] {
        if (pediaElementType == .Monster) { return self.filter({ $0.type == .Monster }) }
        if (pediaElementType == .Fix) { return self.filter({ $0.type == .Fixe }) }
        if (pediaElementType == .Item) { return self.filter({ $0.type == .Item }) }
        return self
    }
    
}

extension Notification.Name {
    static let eventsUpdate = Notification.Name(rawValue: "EVENT_UPDATE")
    static let searchItems = Notification.Name(rawValue: "SEARCH_ITEMS")
    static let updateTable = Notification.Name(rawValue: "UPDATE_TABLE")
}

final class EventRepository {
    
    static var shared = EventRepository()

    lazy var cREventService: CREventsService = CREventsService()
    lazy var cRDataBase = CRDataBase()
    lazy var events: [Event] = []
    lazy var filterType: FilterType = .All
    
    private init() {
        getEvents()
    }

    func getEventSnapshot(withType eventType: Event.EventType) -> NSDiffableDataSourceSnapshot<Event, Event> {
        var snapshot = NSDiffableDataSourceSnapshot<Event, Event>()
        var events: [Event] = []
        
        switch(eventType) {
            case .CurrentEvent: events = getCurrentEvents()
            case .UpcomingEvent: events = getUpcomingEvents().filterByType(withType: filterType)
        }
        snapshot.appendSections(events)

        for section in events {
            snapshot.appendItems([section], toSection: section)
        }
        return snapshot
    }
    
    private func getUpcomingEvents() -> [Event] {
        return events.filter({ $0.type == .UpcomingEvent })
    }
    
    private func getCurrentEvents() -> [Event] {
        return events.filter({ $0.type == .CurrentEvent })
    }
    
    func getEvents() {
        Task {
            do {
                let outposts = try await cREventService.getOutposts()
                let currentEvents = try await cREventService.getCurrentEvents()
                let mothership = try await cREventService.getMotherships()
                var upcomingEvents = outposts + currentEvents
                
                if (upcomingEvents.count == 0) {
                    upcomingEvents = cRDataBase.getAllEvents()
                } else { self.setEventsOnDataBase(upcomingEvents) }
                
                events = outposts + currentEvents + mothership
                NotificationCenter.default.post(name: .eventsUpdate, object: nil)
            } catch {
                print("ERROR")
            }
        }
    }
    
    func deleteCurrentEvent(with event: Event) {
        events = events.filter({ $0.id != event.id })
        NotificationCenter.default.post(name: .eventsUpdate, object: nil)
    }
    
    func changeFilter(with filterType: FilterType) {
        self.filterType = filterType
        NotificationCenter.default.post(name: .eventsUpdate, object: nil)
    }

    func setEventsOnDataBase(_ events: [Event]) {
        self.cRDataBase.deleteAllEvents()
        for event in events {
            let upcomingEvent = UpcomingEventDB(
                deployTime: event.deployTime,
                ani: event.ani,
                bcu: event.bcu,
                outpostName: event.outpostName,
                influence: event.influence
            )
            self.cRDataBase.addEvent(event: upcomingEvent)
        }
    }
    
}
