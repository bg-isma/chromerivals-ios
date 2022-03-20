//
//  HomeController.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 10/3/22.
//

import UIKit

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource, CRViewController {
    
    @IBOutlet weak var homeViewTableContent: UITableView!
    var tableView: UITableView? = nil
    
    lazy var cRViewComponents: [CRViewComponent] = []
    
    init() {
        super.init(nibName: "HomeView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.CRPrimaryColor()
        
        tableView = homeViewTableContent
        let nameNib = UINib(nibName: "CRTableViewCell", bundle: nil)
        homeViewTableContent.register(nameNib, forCellReuseIdentifier: "CRTableCell")
        
        let cREventCollectionComponentVertical = EventCollectionController(.vertical, .UpcomingEvents)
        self.cRViewComponents = [
            HomeHeaderController(),
            UILabel().toChromeRivalsHeader(text: "Current Events", width: self.view.frame.width),
            EventCollectionController(.horizontal, .CurrentEvents),
            UILabel().toChromeRivalsHeader(text: "Upcoming Events", width: self.view.frame.width),
            FilterChipsController([.All, .Motherships, .Outpost], cREventCollectionComponentVertical),
            cREventCollectionComponentVertical
        ]
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cRViewComponents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CRTableCell", for: indexPath) as! CRTableViewCell
        cell.backgroundColor = .white
        return setUpCell(cell, indexPath.item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return setUpCellHeight(indexPath.item)
    }
    
}

extension UILabel: CRViewComponent {
    
    func toChromeRivalsHeader(text: String, width: CGFloat) -> UILabel {
        let upcomingEventFont = UIFont(name: "Nunito Sans Bold", size: 20)
        let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        self.font = upcomingEventFont
        self.textColor = .black
        self.text = text
        self.backgroundColor = .white
        self.sizeToFit()
        self.frame.size.width = self.frame.width + insets.left
        self.frame = self.frame.inset(by: insets)
        return self
    }
    
}

extension CRViewController {
    
    func setUpCell(_ cell: CRTableViewCell, _ index: Int) -> CRTableViewCell {
        let component = cRViewComponents[index]
        switch (component) {
            case is HomeHeaderController: cell.addSubview((component as! HomeHeaderController).view)
            case is UILabel: do {
                let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
                cell.frame = cell.frame.inset(by: insets)
                cell.addSubview((component as! UILabel))
            }
            case is EventCollectionController: cell.addSubview((component as! EventCollectionController).view)
            case is FilterChipsController: cell.addSubview((component as! FilterChipsController).view)
            case is SearchInputController: cell.addSubview((component as! SearchInputController).view)
            case is SearchCollectionController: cell.addSubview((component as! SearchCollectionController).view)
            default: print ("")
        }
        return cell
    }
    
    func setUpCellHeight(_ index: Int) -> CGFloat {
        let component = cRViewComponents[index]
        let isLastCell = index == cRViewComponents.count - 1
        switch (component) {
            case is EventCollectionController where isLastCell: do {
                let cellHeight = getLastCellHeight()
                let componentAsEventCollection = (component as! EventCollectionController)
                componentAsEventCollection.view.frame.size.height = cellHeight - 50
                return cellHeight
            }
            case is SearchCollectionController where isLastCell: do {
                let cellHeight = getLastCellHeight()
                let componentAsSearchCollection = (component as! SearchCollectionController)
                componentAsSearchCollection.view.frame.size.height = cellHeight - 50
                return cellHeight
            }
            case is HomeHeaderController: do {
                let componentAsHeader = (component as! HomeHeaderController)
                return componentAsHeader.contentSize.height
            }
            case is UILabel: do {
                let componentAsLabel = (component as! UILabel)
                return componentAsLabel.intrinsicContentSize.height
            }
            case is EventCollectionController: do {
                let componentAsEventCollection = (component as! EventCollectionController)
                return componentAsEventCollection.contentSize.height
            }
            case is FilterChipsController: do {
                let componentAsFilter = (component as! FilterChipsController)
                let insets = componentAsFilter.insets.top + componentAsFilter.insets.bottom
                return componentAsFilter.contentSize.height + insets
            }
            case is SearchCollectionController: do {
                let componentAsSearchCollection = (component as! SearchCollectionController)
                return componentAsSearchCollection.contentSize.height
            }
            case is SearchInputController: do {
                let componentAsSearchInput = (component as! SearchInputController)
                let insets = componentAsSearchInput.insets.bottom + componentAsSearchInput.insets.top
                return componentAsSearchInput.contentSize.height + insets
            }
            default: return 0
        }
    }
    
    func getLastCellHeight() -> CGFloat {
        var acc = CGFloat(0)
        for (index, _) in cRViewComponents.enumerated() {
            if (index < cRViewComponents.count - 2) {
                acc += setUpCellHeight(index)
            }
        }
        let height = self.tableView?.frame.height ?? 0
        return height - acc
    }
    
}

protocol CRViewComponent {}

protocol CRViewController {
    var cRViewComponents: [CRViewComponent] { get set }
    var tableView: UITableView? { get set }
}

class CRTableViewCell: UITableViewCell {}
