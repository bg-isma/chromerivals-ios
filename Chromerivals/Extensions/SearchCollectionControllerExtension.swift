//
//  SearchCollectionControllerExtension.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 17/3/22.
//

import UIKit


private var reuseIdentifier = "pediaCell"

extension SearchCollectionController: UICollectionViewDataSource, UICollectionViewDelegate {
    
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
    
}
