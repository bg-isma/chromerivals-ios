//
//  CRViewController.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 21/3/22.
//

import Foundation
import UIKit

protocol CRViewController {
    var cRViewComponents: [CRViewComponent] { get set }
    var dataSource: CRDataSource { get }
}
