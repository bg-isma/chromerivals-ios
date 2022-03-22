//
//  FilterChipsControllerExtension.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 21/3/22.
//

import Foundation
import UIKit

private let reuseIdentifier = "chipCell"

extension FilterChipsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FilterChipCell
        cell.filterChipText.text = filters[indexPath.item].rawValue
        return CGSize(width: cell.filterChipText.intrinsicContentSize.width + 30, height: contentSize.height - 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        7
    }
    
}
