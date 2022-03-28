//
//  HomeController.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 10/3/22.
//

import UIKit

private let reuseIdentifier = "CRTableCell"
private let homeControllerNibName = "HomeView"
private let homeTableViewCellNibName = "CRTableViewCell"

final class HomeController: UIViewController, CRViewController, UITableViewDelegate {
    
    @IBOutlet weak var homeViewTableContent: UITableView!
    
    lazy var dataSource: CRDataSource = CRDataSource(tableView: self.homeViewTableContent) { tableview, indexPath, cRComponent in
        return self.setUpCell(at: indexPath, in: tableview, andID: reuseIdentifier)
    }
    
    var snapshot: NSDiffableDataSourceSnapshot<CRSection, UIResponder> {
        var snapshot = NSDiffableDataSourceSnapshot<CRSection, UIResponder>()
        let sections: [CRSection] = [
            .Header,
            .Title("1"),
            .EventList(.horizontal),
            .Title("2"),
            .Filter,
            .EventList(.vertical)
        ]
        snapshot.appendSections(sections)
        
        for (index, section) in sections.enumerated() {
            snapshot.appendItems([self.cRViewComponents[index] as! UIResponder], toSection: section)
        }
        return snapshot
    }
    
    lazy var cRViewComponents: [CRViewComponent] = { () -> [CRViewComponent] in
        let cREventCollectionComponentVertical = EventCollectionController(.vertical, .UpcomingEvents)
        let components: [CRViewComponent] = [
            HomeHeaderController(),
            UILabel().toChromeRivalsHeader(text: "Current Events", width: self.view.frame.width),
            EventCollectionController(.horizontal, .CurrentEvents),
            UILabel().toChromeRivalsHeader(text: "Upcoming Events", width: self.view.frame.width),
            FilterChipsController(withFilters: [.All, .Motherships, .Outpost], for: cREventCollectionComponentVertical),
            cREventCollectionComponentVertical
        ]
        return components
    }()
    
    init() {
        super.init(nibName: homeControllerNibName, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        handleTable()
        self.view.backgroundColor = UIColor.CRPrimaryColor()
    }
    
    func handleTable() {
        NotificationCenter.default.addObserver(forName: .updateTable, object: nil, queue: .main) { observer in
            self.dataSource.apply(self.snapshot)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cRViewComponents[indexPath.section].height
    }
    
    func setUpTableView() {
        let nameNib = UINib(nibName: homeTableViewCellNibName, bundle: nil)
        homeViewTableContent.register(nameNib, forCellReuseIdentifier: reuseIdentifier)
        homeViewTableContent.dataSource = dataSource
        homeViewTableContent.frame.size.height = self.view.frame.height
        homeViewTableContent.isScrollEnabled = true
        homeViewTableContent.backgroundColor = .white
        dataSource.apply(snapshot)
    }

}

class CRTableViewCell: UITableViewCell {}

class CRDataSource: UITableViewDiffableDataSource<CRSection, UIResponder> {}
