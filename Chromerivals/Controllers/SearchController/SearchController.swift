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

class SearchController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource,
    CRViewController {
    
    @IBOutlet weak var searchTableViewContent: UITableView!
    
    var tableView: UITableView? = nil
    var cRViewComponents: [CRViewComponent] = []
    
    init() {
        super.init(nibName: searchControllerTableNibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = searchTableViewContent
        let nameNib = UINib(nibName: searchControllerNibName, bundle: nil)
        searchTableViewContent.register(nameNib, forCellReuseIdentifier: reuseIdentifier)

        let cRSearchCollectionController = SearchCollectionController(self)
        cRViewComponents = [
            SearchInputController(cRSearchCollectionController),
            FilterChipsController(withFilters:[.All, .Item, .Monster], for: cRSearchCollectionController),
            cRSearchCollectionController
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
