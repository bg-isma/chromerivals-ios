//
//  HomeController.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 10/3/22.
//

import UIKit

private let reuseIdentifier = "CRTableCell"
private let homeControllerNibName = "HomeView"

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource, CRViewController {
    
    @IBOutlet weak var homeViewTableContent: UITableView!
    var tableView: UITableView? = nil
    
    lazy var cRViewComponents: [CRViewComponent] = []
    
    init() {
        super.init(nibName: homeControllerNibName, bundle: nil)
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
            FilterChipsController(withFilters: [.All, .Motherships, .Outpost], for: cREventCollectionComponentVertical),
            cREventCollectionComponentVertical
        ]
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cRViewComponents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CRTableViewCell
        return setUpCell(with: cell, at: indexPath.item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return setUpCellHeight(at: indexPath.item)
    }
    
}

class CRTableViewCell: UITableViewCell {}
