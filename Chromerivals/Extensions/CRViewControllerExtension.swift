//
//  CRViewController.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 21/3/22.
//

import Foundation
import UIKit

extension CRViewController {
    
    func setUpCell(at index: IndexPath, in tableView: UITableView, andID reuseIdentifier: String) -> CRTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: index) as! CRTableViewCell
        cell.frame.size.height = self.setUpCellHeight(at: index.section, in: tableView)
        cell.addSubview(cRViewComponents[index.section].componentView)
        return cell
    }
    
    func setUpCellHeight(at index: Int, in tableView: UITableView) -> CGFloat {
        let lastIndex = index == cRViewComponents.count - 1 ? true : false
        let component = cRViewComponents[index]
        let height = component.height
        if (lastIndex) {
            let lastCellHeight = getLastCellHeight(in: tableView)
            if ((lastCellHeight - component.height) >= 0) {
                setUpTableScroll(isEnabled: false, in: tableView)
                component.componentView.frame.size.height = lastCellHeight
                return lastCellHeight
            }
            setUpTableScroll(isEnabled: true, in: tableView)
            return height
        }
        return height
    }
    
    func getLastCellHeight(in tableView: UITableView) -> CGFloat {
        var cellsHeight = 0.0
        for index in 0...(cRViewComponents.count - 2) {
            cellsHeight += setUpCellHeight(at: index, in: tableView)
        }
        let tableHeight = tableView.frame.height
        return tableHeight - cellsHeight
    }
    
    func setUpTableScroll(isEnabled: Bool, in tableView: UITableView) {
        tableView.isScrollEnabled = isEnabled
    }
    
}
