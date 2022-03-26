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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var componentView: UIView {
        self.view
    }
    
    var height: CGFloat {
        contentSize.height + insets.bottom + insets.top
    }
    
    lazy var filters: [FilterType] = []
    lazy var collectionViewController: CRViewComponent? = nil
    lazy var selectedItem: Int = 0
    lazy var contentSize: CGSize = CGSize(width: 0, height: 30)
    lazy var insets: UIEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
    
    init(withFilters filters: [FilterType], for controller: CRViewComponent) {
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
        self.view.frame.size.height = height
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
        cell.filterChipText.text = filters[indexPath.item].rawValue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filter(with: filters[indexPath.item])
        selectedItem = indexPath.item
        collectionView.reloadData()
    }
    
    func filter(with filter: FilterType) {
        if let collectionController = collectionViewController {
            switch (collectionController) {
                case is EventCollectionController: do {
                    let component = (collectionController as! EventCollectionController)
                    component.eventRepository.changeFilter(with: filter)
                }
                case is SearchCollectionController: do {
                    let component = (collectionController as! SearchCollectionController)
                    component.pediaRepository.changeFilter(with: filter)
                }
                default: print("no controller")
            }
 
        }
    }
    
}
