//
//  HomeHeaderController.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 10/3/22.
//

import UIKit

class HomeHeaderController: UIViewController, CRViewComponent {

    @IBOutlet weak var roundedHeaderView: UIView!
    @IBOutlet weak var headerContent: UIView!
    @IBOutlet weak var companyName: UILabel!
    
    lazy var contentSize: CGSize = CGSize(width: 0, height: 120)
    
    init() {
        super.init(nibName: "HomeHeaderView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyName.font = UIFont(name: "Nunito Sans Bold", size: 20)
        self.view.backgroundColor = UIColor.CRPrimaryColor()
        roundedHeaderView.layer.cornerRadius = 25
        roundedHeaderView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

}
