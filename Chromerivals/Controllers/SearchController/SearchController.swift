//
//  SearchController.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 10/3/22.
//

import UIKit

class SearchController: UIViewController, UITableViewDelegate, UITableViewDataSource, CRViewController {
    
    @IBOutlet weak var searchTableViewContent: UITableView!
    var tableView: UITableView? = nil
    
    var cRViewComponents: [CRViewComponent] = []
    
    init() {
        super.init(nibName: "SearchView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = searchTableViewContent
        let nameNib = UINib(nibName: "CRTableViewCell", bundle: nil)
        searchTableViewContent.register(nameNib, forCellReuseIdentifier: "CRTableCell")

        let cRSearchCollectionController = SearchCollectionController(self)
        cRViewComponents = [
            SearchInputController(cRSearchCollectionController),
            FilterChipsController([.All, .Item, .Monster], cRSearchCollectionController),
            cRSearchCollectionController
        ]

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cRViewComponents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CRTableCell", for: indexPath) as! CRTableViewCell
        return setUpCell(cell, indexPath.item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return setUpCellHeight(indexPath.item)
    }
    
}
