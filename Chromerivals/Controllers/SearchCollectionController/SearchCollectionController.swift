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
    UICollectionViewDelegate,
    CRViewComponent {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pediaRepository: PediaRepository = PediaRepository.shared
    lazy var dataSource: PediaDataSource = PediaDataSource(collectionView: self.collectionView) { collectionView, indexPath, pediaElement in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SearchCollectionViewCell
        cell.frame.size.width = collectionView.frame.width - 10
        cell.setUpCellContent(pediaElement: pediaElement)
        return cell
    }
    
    var componentView: UIView {
        self.view
    }
    
    var height: CGFloat {
        contentSize.height + insets.top + insets.bottom
    }
    
    lazy var root: UIViewController? = nil
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
        self.collectionView.dataSource = dataSource
        handleEvents()
    }
    
    func handleEvents() {
        NotificationCenter.default.addObserver(forName: .searchItems, object: nil, queue: .main) { [self] observer in
            dataSource.apply(pediaRepository.getSearchSnapshot())
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController =
        PediaItemDetailViewController(pediaRepository.searchedItems[indexPath.section])
        detailController.modalPresentationStyle = .fullScreen
        root?.present(detailController, animated: false, completion: nil)
    }

}

final class PediaDataSource: UICollectionViewDiffableDataSource<PediaElement, PediaElement> {}
