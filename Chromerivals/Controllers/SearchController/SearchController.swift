//
//  SearchController.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 10/3/22.
//

import UIKit

private let reuseIdentifier = "CRTableCell"
private let searchControllerNibName = "CRTableViewCell"
private let searchControllerTableNibName = "SearchView"

final class SearchController:
    UIViewController,
    UITableViewDelegate,
    CRViewController {
    
    @IBOutlet weak var searchTableViewContent: UITableView!
    
    lazy var dataSource: CRDataSource = CRDataSource(tableView: self.searchTableViewContent) { tableview, indexPath, cRComponent in
        return self.setUpCell(at: indexPath, in: tableview, andID: reuseIdentifier)
    }
    
    lazy var cRViewComponents: [CRViewComponent] = { () -> [CRViewComponent] in
        let cRSearchCollectionController = SearchCollectionController(self)
        let components: [CRViewComponent] = [
            SearchInputController(cRSearchCollectionController),
            FilterChipsController(withFilters:[.All, .Item, .Monster], for: cRSearchCollectionController),
            cRSearchCollectionController
        ]
        return components
    }()
    
    var snapshot: NSDiffableDataSourceSnapshot<CRSection, UIResponder> {
        var snapshot = NSDiffableDataSourceSnapshot<CRSection, UIResponder>()
        let sections: [CRSection] = [
            .SearchInput,
            .Filter,
            .SearchList
        ]
        snapshot.appendSections(sections)
        
        for (index, section) in sections.enumerated() {
            snapshot.appendItems([self.cRViewComponents[index] as! UIResponder], toSection: section)
        }
        return snapshot
    }
    
    init() {
        super.init(nibName: searchControllerTableNibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleTable()
        setUpTableView()
    }
    
    func setUpTableView() {
        let nameNib = UINib(nibName: searchControllerNibName, bundle: nil)
        searchTableViewContent.register(nameNib, forCellReuseIdentifier: reuseIdentifier)
        searchTableViewContent.dataSource = dataSource
        searchTableViewContent.isScrollEnabled = true
        dataSource.apply(snapshot)
    }
    
    func handleTable() {
        NotificationCenter.default.addObserver(forName: .updateTable, object: nil, queue: .main) { observer in
            self.dataSource.apply(self.snapshot)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cRViewComponents[indexPath.section].height
    }
    
    
}
