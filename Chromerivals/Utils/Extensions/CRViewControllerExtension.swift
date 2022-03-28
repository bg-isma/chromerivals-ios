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
        let component = cRViewComponents[index.section]
        cell.addSubview(component.componentView)
        return cell
    }
    
}
