//
//  EventCollectionControllerExtension.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 22/3/22.
//

import Foundation
import UIKit

extension EventCollectionController: UICollectionViewDelegateFlowLayout {
    
    enum EventCollectionType {
        case CurrentEvents
        case UpcomingEvents
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch (direction) {
            case .vertical: return UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
            case .horizontal: return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
            default: return  UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
}
