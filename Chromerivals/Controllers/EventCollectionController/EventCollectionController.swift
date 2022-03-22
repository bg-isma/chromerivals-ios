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

class EventCollectionController:
    UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    CRViewComponent {

    @IBOutlet var collectionView: UICollectionView!
    
    var contentSize: CGSize {
        if (direction == .vertical) { return CGSize(width: 0, height: 300) }
        else { return CGSize(width: 0, height: 110) }
    }

    var insets: UIEdgeInsets {
        if (direction == .vertical) { return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) }
        else { return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0) }
    }
    
    var height: CGFloat {
        contentSize.height + insets.top + insets.bottom
    }
    
    var componentView: UIView {
        self.view
    }
    
    lazy var direction: UICollectionView.ScrollDirection = .vertical
    lazy var chromerivalsService: CREventsService = CREventsService()
    lazy var cRDataBase = CRDataBase()
    lazy var events: [Event] = [ /*CurrentEvent(endTime: "2022-03-22T04:10:00+01:00", mapName: "Castor")*/ ]
    lazy var eventsNoFiltered: [Event] = []
    lazy var type: EventCollectionType = .UpcomingEvents
    
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
        self.view.frame.size.height = height
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
        cell.cellPosition = indexPath.item
        return cell.getCellWithEventContent(withEvent: events[indexPath.item], and: self)
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
        switch (filterType) {
            case .Outpost: do {
                events = eventsNoFiltered.filter({ $0 is UpcomingEvent })
            }
            case .Motherships: do {
                events = eventsNoFiltered.filter({ $0 is UpcomingEvent })
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
