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

class SearchCollectionController: UIViewController, CRViewComponent {

    @IBOutlet weak var collectionView: UICollectionView!
    
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
        self.view.frame.size.height = contentSize.height + insets.top + insets.bottom
        self.view.frame =  self.view.frame.inset(by: insets)
        let nameNib = UINib(nibName: pediaCellNibName, bundle: nil)
        self.collectionView.register(nameNib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func filterByType(filterType: FilterType) {
        switch (filterType) {
            case .Item: do {
                searchedItems = searchedItemsNoFiltered.filter({ $0 is Item })
            }
            case .Monster: do {
                searchedItems = searchedItemsNoFiltered.filter({ $0 is Monster })
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

extension UIImageView {

    func makeRounded() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.CRPrimaryColor().cgColor
    }
    
}

extension SearchCollectionController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }

}
