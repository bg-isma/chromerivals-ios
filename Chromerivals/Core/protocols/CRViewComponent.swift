//
//  CRViewComponent.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 21/3/22.
//

import Foundation
import UIKit

protocol CRViewComponent{
    var contentSize: CGSize { get }
    var insets: UIEdgeInsets { get }
    var height: CGFloat { get }
    var componentView: UIView { get }
}

enum FilterType: String {
    case All = "All"
    case Motherships = "Motherships"
    case Outpost = "Outpost"
    case Item = "Item"
    case Monster = "Monster"
    case Fix = "Fix"
}

enum CRSection: Hashable {
    case Filter
    case EventList(UICollectionView.ScrollDirection)
    case SearchList
    case SearchInput
    case Title(String)
    case Header
}
