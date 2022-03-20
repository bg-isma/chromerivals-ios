//
//  EventCollectionController.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 12/3/22.
//

import UIKit

private let reuseIdentifier = "cell"
private let eventCellNibName = "EventCellView"
private let eventCollectionNibName = "EventCollectionControllerView"

class EventCollectionController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CRViewComponent {
    
    lazy var direction: UICollectionView.ScrollDirection = .vertical
    var contentSize: CGSize {
        if (direction == .vertical) { return CGSize(width: 0, height: 300) }
        else { return CGSize(width: 0, height: 110) }
    }

    var insets: UIEdgeInsets {
        if (direction == .vertical) { return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) }
        else { return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0) }
    }
    
    lazy var chromerivalsService: CREventsService = CREventsService()
    lazy var cRDataBase = CRDataBase()

    lazy var events: [Event] = []
    lazy var eventsNoFiltered: [Event] = []
    lazy var type: EventCollectionType = .UpcomingEvents
    
    @IBOutlet var collectionView: UICollectionView!
    
    init(_ direction: UICollectionView.ScrollDirection,_ type: EventCollectionType) {
        super.init(nibName: eventCollectionNibName, bundle: nil)
        self.direction = direction
        self.type = type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame.size.height = contentSize.height + insets.top + insets.bottom
        if let layout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = direction
        }
        
        let eventNib = UINib(nibName: eventCellNibName, bundle: nil)
        collectionView.register(eventNib, forCellWithReuseIdentifier: reuseIdentifier)
        
        setInsets()
        getEvents()
    }
    
    func getEvents() {
        switch (type) {
            case .UpcomingEvents: getUpcomingEvents()
            case .CurrentEvents: getCurrentEvents()
        }
    }
    
    func setInsets() {
        switch (direction) {
            case .vertical: do {
                self.view.frame =  self.view.frame.inset(by: insets)
            }
            case .horizontal: do {
                self.view.frame =  self.view.frame.inset(by: insets)
            }
            default: print("no special insets")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EventViewCell
        
        let event = events[indexPath.item]
        
        if (event is UpcomingEvent) {
            let event = events[indexPath.item] as! UpcomingEvent
            cell.eventNationTimerText.text = event.deployTime?.toLocalDateString()
            cell.setEventDate()
            var actualEvent = events[indexPath.item] as! UpcomingEvent
            if (actualEvent.ani != nil) {
                cell.eventNationMapName.text = "Reynard beach"
                cell.eventNationTypeName.text = "Mothership"
                cell.eventNationTimerText.text = event.ani?.toLocalDateString()
                cell.setToANINationCard()
            }
            if (actualEvent.bcu != nil) {
                cell.eventNationMapName.text = "Tylent Jungle"
                cell.eventNationTypeName.text = "Mothership"
                cell.eventNationTimerText.text = event.bcu?.toLocalDateString()
                cell.setToBCUNationCard()
            }
            if (actualEvent.influence != nil) {
                switch (actualEvent.influence) {
                    case 4: cell.setToANINationCard()
                    case 2: cell.setToBCUNationCard()
                    default: print("")
                }
            }
            
            if (actualEvent.outpostName != nil) {
                cell.eventNationTypeName.text = "Outpost"
                cell.eventNationMapName.text = actualEvent.outpostName?.deleteStrangeCharacters()
            }
        } else {
            let current = event as! CurrentEvent
            let endTime = current.endTime?.toLocalDate()
            cell.eventNationTypeName.text = typeName(current.eventType ?? 0)
            cell.eventNationMapName.text = current.mapName
            cell.initTimer(controller: self, date: endTime ?? Date(), collectionPosition: indexPath.item)
            cell.setToBCUNationCard()
        }
        
        return cell
    }
    
    func typeName(_ eventType: Double) -> String {
       switch (Int(eventType)) {
           case 27: return "Nation Kill Event"
           case 28: return "Free For All"
           case 3: return "Outpost"
           default: return "Free For All"
       }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = CGFloat(109)
        switch (direction) {
            case .vertical: return CGSize(width: collectionView.frame.width, height: cellHeight)
            case .horizontal: return CGSize(width: 310, height: cellHeight)
            default: return CGSize(width: 300, height: cellHeight)
        }
    }
    
    func filterByType(filterType: FilterType) {
        let outpostCondition = { (event: UpcomingEvent) -> Bool in (event.outpostName != nil) }
        let mothershipsCondition = { (event: UpcomingEvent) -> Bool in (event.ani != nil) || (event.bcu != nil) }
        
        switch (filterType) {
            case .Outpost: do {
                events = eventsNoFiltered.filter({ outpostCondition($0 as! UpcomingEvent) })
            }
            case .Motherships: do {
                events = eventsNoFiltered.filter({ mothershipsCondition($0 as! UpcomingEvent) })
            }
            default: events = eventsNoFiltered
        }
        collectionView.reloadData()
    }
    
    func reloadEventControllerData(_ newEvents: [Event]) {
        events = newEvents
        eventsNoFiltered = newEvents
        collectionView.reloadData()
    }
    
    func getUpcomingEvents() {
        chromerivalsService.getOutposts() { outpost in
            self.chromerivalsService.getMotherships() { motherships in
                var events = outpost + motherships
                if (events.count == 0) {
                    events = self.cRDataBase.getAllEvents()
                } else { self.setEventsOnDataBase(events as! [UpcomingEvent]) }
                self.reloadEventControllerData(events)
            }
        }
    }
    
    func setEventsOnDataBase(_ events: [UpcomingEvent]) {
        DispatchQueue(label: "background").async {
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
    
    func getCurrentEvents() {
        chromerivalsService.getCurrentEvents { currentEvents in
            self.reloadEventControllerData(currentEvents)
        }
    }
    

    
}

extension String {
    
    func toLocalDate() -> Date {
        let dateFormatter = DateFormatter() // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone.current
        let date = dateFormatter.date(from: self) ?? Date()
        return date
    }
    
    func toLocalDateString() -> String {
        let dateFormatter = DateFormatter() // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        dateFormatter.timeZone = TimeZone(identifier: "Europe/Paris")
        var date = dateFormatter.date(from: self) ?? Date()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let serverDateString = dateFormatter.string(from: date)
        
        dateFormatter.timeZone = TimeZone.current
        date = dateFormatter.date(from: serverDateString) ?? Date()
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([ .month, .day, .year, .hour, .minute], from: date)
        
        return String(format: "%02d-%02d-%02d %02d:%02d",
                      components.year ?? "yyyy",
                      components.month ?? "MM",
                      components.day ?? "dd",
                      components.hour ?? 00,
                      components.minute ?? 00
        )
    }
    
}

enum FilterType {
    case All
    case Motherships
    case Outpost
    case Item
    case Monster
    case Fix
    
    func getTypeText() -> String {
        switch (self) {
            case .Outpost: return "Outpost"
            case .Motherships: return "Motherships"
            case .Item: return "Item"
            case .Monster: return "Monster"
            case .Fix: return "Fix"
            default: return "All"
        }
    }
}

extension EventCollectionController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch (direction) {
            case .vertical: return UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
            case .horizontal: return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
            default: return  UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
}

enum EventCollectionType {
    case CurrentEvents
    case UpcomingEvents
}

