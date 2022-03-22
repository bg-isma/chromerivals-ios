//
//  EventCellController.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 10/3/22.
//

import UIKit

class EventViewCell: UICollectionViewCell {
    
    @IBOutlet weak var eventCellContent: UIView!
    @IBOutlet weak var eventNationMapName: UILabel!
    @IBOutlet weak var eventNationTypeName: UILabel!
    @IBOutlet weak var eventNationTimerText: UILabel!
    @IBOutlet weak var eventNationLogo: UIImageView!
    
    lazy var nowDate = Date()
    lazy var cellPosition = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }
    
    func initTimer(controller: EventCollectionController, date: Date) {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
            self.eventNationTimerText.text = self.nowDate.countDownString(until: date)
            self.nowDate = Date()
            if (self.nowDate > date) {
                timer.invalidate()
                
                let events = controller.events
                for (index, _) in events.enumerated() {
                    if (index == cellPosition) {
                        controller.events.remove(at: index)
                        controller.collectionView.reloadData()
                    }
                }
                
            }
        }
    }
    
    func setToANINationCard() {
        self.eventCellContent.backgroundColor = UIColor.CRPrimaryColor()
        self.eventNationLogo.image = UIImage(named: "ANI_LOGO")
    }
    
    func setToBCUNationCard() {
        self.eventCellContent.backgroundColor = UIColor.CRSecundaryColor()
        self.eventNationLogo.image = UIImage(named: "BCU_LOGO")
    }
    
    func setEventDate() {
        eventNationTimerText.font = eventNationTimerText.font.withSize(14)
    }
    
    func setUpCell() {
        eventNationMapName.font = UIFont(name: "Nunito Sans ExtraBold", size: 20)
        eventNationTypeName.font = UIFont(name: "Nunito Sans Bold", size: 17)
        eventNationTimerText.font = UIFont(name: "Nunito Sans SemiBold", size: 20)
        eventCellContent.layer.cornerRadius = 10
    }
    
    func getCellWithEventContent(
        withEvent event: Event,
        and controller: EventCollectionController
    ) -> EventViewCell {
        switch (event) {
            case is UpcomingEvent: do {
                let upcomingEvent = event as! UpcomingEvent
                setUpcomingEventContent(with: upcomingEvent)
                setCellNation(nation: Int(upcomingEvent.influence ?? 2))
            }
            case is CurrentEvent: do {
                let currentEvent = event as! CurrentEvent
                setCurrentEventContent(with: currentEvent, and: controller)
            }
            default: print("other type")
        }
        return self
    }
    
    private func setCellNation(nation: Int) {
        switch (nation) {
            case 4: setToANINationCard()
            case 2: setToBCUNationCard()
            default: print("")
        }
    }
    
    private func setCurrentEventContent(
        with currentEvent: CurrentEvent,
        and controller: EventCollectionController
    ) {
        let endTime = currentEvent.endTime?.toLocalDate()
        eventNationTypeName.text = typeName(currentEvent.eventType ?? 0)
        eventNationMapName.text = currentEvent.mapName
        initTimer(controller: controller, date: endTime ?? Date())
        setToBCUNationCard()
    }
    
    private func typeName(_ eventType: Double) -> String {
       switch (Int(eventType)) {
           case 27: return "Nation Kill Event"
           case 28: return "Free For All"
           case 3: return "Outpost"
           default: return "Free For All"
       }
    }
    
    private func setUpcomingEventContent(with upcomingEvent: UpcomingEvent) {
        switch (upcomingEvent) {
            case upcomingEvent where upcomingEvent.ani != nil: do {
                let date = upcomingEvent.ani?.toLocalDateString() ?? ""
                setMothership(withMapName: "Reynard beach", andDate: date)
            }
            case upcomingEvent where upcomingEvent.bcu != nil: do {
                let date = upcomingEvent.bcu?.toLocalDateString() ?? ""
                setMothership(withMapName: "Tylent Jungle", andDate: date)
            }
            case upcomingEvent where upcomingEvent.outpostName != nil: do {
                var mapName = upcomingEvent.outpostName ?? ""
                let mapNameFormated = mapName.deleteStrangeCharacters()
                let date = upcomingEvent.deployTime?.toLocalDateString() ?? ""
                setOutpost(withMapName: mapNameFormated, andDate: date)
            }
            default: print("")
        }
        setEventDate()
    }
    
    private func setMothership(withMapName mapName: String, andDate date: String) {
        eventNationMapName.text = mapName
        eventNationTypeName.text = "Mothership"
        eventNationTimerText.text = date
    }
    
    private func setOutpost(withMapName mapName: String, andDate date: String) {
        eventNationMapName.text = mapName
        eventNationTypeName.text = "Outpost"
        eventNationTimerText.text = date
    }
    
}
