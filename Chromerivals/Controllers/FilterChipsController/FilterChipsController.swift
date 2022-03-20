//
//  FilterChipsController.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 12/3/22.
//

import UIKit

private let reuseIdentifier = "chipCell"
private let filterCellNibName = "FilterChipCellView"
private let filterCollectionNibName = "FilterChipControllerView"

class FilterChipsController:
    UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    CRViewComponent {
    
    lazy var filters: [FilterType] = []
    lazy var collectionViewController: UIViewController? = nil
    lazy var selectedItem: Int = 0
    
    lazy var contentSize: CGSize = CGSize(width: 0, height: 30)
    lazy var insets: UIEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)

    @IBOutlet weak var collectionView: UICollectionView!
    
    init(_ filters: [FilterType], _ controller: UIViewController) {
        super.init(nibName: filterCollectionNibName, bundle: nil)
        self.filters = filters
        self.collectionViewController = controller
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nameNib = UINib(nibName: filterCellNibName, bundle: nil)
        collectionView.register(nameNib, forCellWithReuseIdentifier: reuseIdentifier)
        self.view.frame.size.height = contentSize.height + insets.bottom + insets.top
        self.view.frame = self.view.frame.inset(by: insets)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FilterChipCell
        if (indexPath.item == selectedItem) {
            cell.select()
        } else { cell.unSelect() }
        cell.filterChipText.text = filters[indexPath.item].getTypeText()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let collectionController = collectionViewController {
            switch (collectionController) {
                case is EventCollectionController: do {
                    (collectionController as! EventCollectionController).filterByType(filterType: filters[indexPath.item])
                }
                case is SearchCollectionController: do {
                    (collectionController as! SearchCollectionController).filterByType(filterType: filters[indexPath.item])
                }
                default: print("no controller")
            }
 
        }
        selectedItem = indexPath.item
        collectionView.reloadData()
    }

}

class FilterChipCell: UICollectionViewCell {
    
    @IBOutlet weak var filterChipContent: UIView!
    @IBOutlet weak var filterChipText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpChip()
    }
    
    func setUpChip() {
        filterChipContent.layer.borderWidth = 1
        filterChipContent.layer.cornerRadius = 16
        filterChipContent.layer.borderColor = UIColor.black.cgColor
    }
    
    func select() {
        filterChipContent.backgroundColor = .black
        filterChipText.textColor = .white
        filterChipContent.layer.borderColor = UIColor.black.cgColor
    }
    
    func unSelect() {
        filterChipContent.backgroundColor = .white
        filterChipText.textColor = .black
    }
    
}

extension FilterChipsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FilterChipCell
        cell.filterChipText.text = filters[indexPath.item].getTypeText()
        return CGSize(width: cell.filterChipText.intrinsicContentSize.width + 30, height: contentSize.height - 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        7
    }
    
}
