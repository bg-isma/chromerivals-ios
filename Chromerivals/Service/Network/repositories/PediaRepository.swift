//
//  PediaRepository.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 24/3/22.
//

import Foundation
import UIKit

final class PediaRepository {
    
    static var shared = PediaRepository()
    
    lazy var cRPediaService: CRPediaService = CRPediaService()
    lazy var searchedItems: [PediaElement] = []
    
    var filterType: FilterType = .All
    
    func searchItems(query: String) {
        cRPediaService.getSearchedItems(query: query) { items in
            self.searchedItems = items
            NotificationCenter.default.post(name: .searchItems, object: nil)
        }
    }
    
    func changeFilter(with filterType: FilterType) {
        self.filterType = filterType
        NotificationCenter.default.post(name: .searchItems, object: nil)
    }
    
    func getSearchSnapshot() -> NSDiffableDataSourceSnapshot<PediaElement, PediaElement> {
        var snapshot = NSDiffableDataSourceSnapshot<PediaElement, PediaElement>()
        let items: [PediaElement] = searchedItems.filterByType(withType: filterType)
        snapshot.appendSections(items)
        
        for section in items {
            snapshot.appendItems([section], toSection: section)
        }
        return snapshot
    }
    
}
