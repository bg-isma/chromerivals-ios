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

final class EventCollectionController: UIViewController, UICollectionViewDelegate, CRViewComponent {

    @IBOutlet var collectionView: UICollectionView!
    
    lazy var id: UUID = UUID()
    
    var eventRepository: EventRepository = EventRepository.shared
    lazy var dataSource: EventDataSource = EventDataSource(collectionView: self.collectionView) { collectionView, indexPath, event in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EventViewCell
        cell.event = event
        return cell.getCellWithEventContent(withEvent: event, and: self)
    }
    
    var contentSize: CGSize {
        if (direction == .vertical) {
            let numEvents: Int = eventRepository.events.filter({ $0.type == Event.EventType.UpcomingEvent }).count
            return CGSize(width: 0, height: 113 * numEvents)
        } else { return CGSize(width: 0, height: 110) }
    }

    var insets: UIEdgeInsets {
        if (direction == .vertical) { return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) }
        else { return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0) }
    }
    
    var height: CGFloat {
        contentSize.height + insets.top + insets.bottom
    }
    
    var componentView: UIView { self.view }
    
    lazy var direction: UICollectionView.ScrollDirection = .vertical
    lazy var type: Event.EventType = .UpcomingEvent
    
    init(_ direction: UICollectionView.ScrollDirection,_ type: EventCollectionType) {
        super.init(nibName: eventCollectionNibName, bundle: nil)
        self.direction = direction
        switch(type) {
            case .UpcomingEvents: self.type = .UpcomingEvent
            case .CurrentEvents: self.type = .CurrentEvent
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleEvents()
        setUpEventCollection()
        setUpCollection()
    }
    
    func handleEvents() {
        NotificationCenter.default.addObserver(forName: .eventsUpdate, object: nil, queue: .main) { [self] observer in
            dataSource.apply(eventRepository.getEventSnapshot(withType: type))
            setUpHeight()
            NotificationCenter.default.post(name: .updateTable, object: nil)
        }
    }
    
    func setUpCollection() {
        if let layout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = direction
        }
        let eventNib = UINib(nibName: eventCellNibName, bundle: nil)
        collectionView.register(eventNib, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = dataSource
    }
    
    func setUpHeight() {
        self.view.frame.size.height = height
    }
    
    func setUpEventCollection() {
        switch (direction) {
            case .vertical: do {
                collectionView.isScrollEnabled = false
                self.view.frame =  self.view.frame.inset(by: insets)
            }
            case .horizontal: do {
                collectionView.isScrollEnabled = true
                self.view.frame =  self.view.frame.inset(by: insets)
            }
            default: print("no special insets")
        }
        self.view.frame.size.height = contentSize.height + insets.top + insets.bottom
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = CGFloat(109)
        switch (direction) {
            case .vertical: return CGSize(width: collectionView.frame.width, height: cellHeight)
            case .horizontal: return CGSize(width: 310, height: cellHeight)
            default: return CGSize(width: 300, height: cellHeight)
        }
    }
    
}

final class EventDataSource: UICollectionViewDiffableDataSource<Event, Event> {}
