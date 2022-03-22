//
//  SearchCollectionController.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 13/3/22.
//

import UIKit

private var reuseIdentifier = "pediaCell"
private var pediaCellNibName = "SearchCollectionViewCell"
private let searchCollectionNibName = "SearchCollectionView"

class SearchCollectionController:
    UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    CRViewComponent {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var componentView: UIView {
        self.view
    }
    
    var height: CGFloat {
        contentSize.height + insets.top + insets.bottom
    }
    
    lazy var root: UIViewController? = nil
    lazy var chromerivalsService: CRPediaService = CRPediaService()
    lazy var searchedItems: [PediaElement] = []
    lazy var searchedItemsNoFiltered: [PediaElement] = []
    lazy var contentSize: CGSize = CGSize(width: 0, height: 300)
    lazy var insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    
    init(_ root: UIViewController) {
        super.init(nibName: searchCollectionNibName, bundle: nil)
        self.root = root
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame.size.height = height
        self.view.frame = self.view.frame.inset(by: insets)
        let nameNib = UINib(nibName: pediaCellNibName, bundle: nil)
        self.collectionView.register(nameNib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SearchCollectionViewCell
        cell.setUpCellContent(pediaElement: &searchedItems[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController =
        PediaItemDetailViewController(searchedItems[indexPath.item])
        detailController.modalPresentationStyle = .fullScreen
        root?.present(detailController, animated: false, completion: nil)
    }
    
    func filterByType(filterType: FilterType) {
        switch (filterType) {
            case .Item: do {
                searchedItems = searchedItemsNoFiltered.filter({ $0 is Item })
            }
            case .Monster: do {
                searchedItems = searchedItemsNoFiltered.filter({ $0 is Monster })
            }
            case .Fix: do {
                searchedItems = searchedItemsNoFiltered.filter({ $0 is Fix })
            }
            default: searchedItems = searchedItemsNoFiltered
        }
        collectionView.reloadData()
    }
    
    func reloadItemsControllerData(_ newItems: [PediaElement]) {
        searchedItems = newItems
        searchedItemsNoFiltered = newItems
        collectionView.reloadData()
    }
    
    func searchItems(query: String) {
        chromerivalsService.getSearchedItems(query: query) { items in
            self.reloadItemsControllerData(items)
        }
    }

}
