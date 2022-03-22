//
//  CRViewController.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 21/3/22.
//

import Foundation
import UIKit

extension CRViewController {
    
    func setUpCell(with cell: CRTableViewCell, at index: Int) -> CRTableViewCell {
        let component = cRViewComponents[index]
        cell.addSubview(component.componentView)
        return cell
    }
    
    func setUpCellHeight(at index: Int) -> CGFloat {
        let lastIndex = index == cRViewComponents.count - 1 ? true : false
        let component = cRViewComponents[index]
        let height = component.height
        if (lastIndex) {
            let lastCellHeight = getLastCellHeight()
            if ((lastCellHeight - component.height) >= 0) {
                setUpTableScroll(isEnabled: false)
                component.componentView.frame.size.height = lastCellHeight
                return lastCellHeight
            }
            setUpTableScroll(isEnabled: true)
            return height
        }
        return height
    }
    
    func getLastCellHeight() -> CGFloat {
        var cellsHeight = 0.0
        for index in 0...(cRViewComponents.count - 2) {
            cellsHeight += setUpCellHeight(at: index)
        }
        let tableHeight = self.tableView?.frame.height ?? 0
        return tableHeight - cellsHeight
    }
    
    func setUpTableScroll(isEnabled: Bool) {
        self.tableView?.isScrollEnabled = isEnabled
    }
    
}
