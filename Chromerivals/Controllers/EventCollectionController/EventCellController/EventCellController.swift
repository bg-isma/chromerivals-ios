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
    
    lazy var collectionViewPosition = 0
    lazy var nowDate = Date()
    lazy var referenceDate = Date()
    lazy var eventController: EventCollectionController? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventCellContent.layer.cornerRadius = 10
        setUpCell()
    }
    
    func initTimer(controller: EventCollectionController, date: Date, collectionPosition: Int) {
        self.referenceDate = date
        self.eventController = controller
        self.collectionViewPosition = collectionPosition
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
            self.eventNationTimerText.text = self.countDownString(from: self.nowDate, until: self.referenceDate)
            self.nowDate = Date()
            if (self.nowDate > self.referenceDate) {
                timer.invalidate()
                
                let events = self.eventController?.events ?? []
                for (index, _) in events.enumerated() {
                    if (index == self.collectionViewPosition) {
                        self.eventController?.events.remove(at: index)
                        self.eventController?.collectionView.reloadData()
                    }
                }
                
            }
        }
    }
    
    func countDownString(from date: Date, until nowDate: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.minute, .second], from: date, to: nowDate)
        return String(format: "%02d:%02d", components.minute ?? 00, components.second ?? 00)
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
    }
    
}
