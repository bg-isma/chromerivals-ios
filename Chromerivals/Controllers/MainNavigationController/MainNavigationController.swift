//
//  MainNavigationController.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 9/3/22.
//

import UIKit

class MainNavigationController: UITabBarController {
    
    
    lazy var chromerivalsControllers: [UINavigationController] = [
        UINavigationController(rootViewController: HomeController()),
        UINavigationController(rootViewController: SearchController())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        chromerivalsControllers[0].setNavigationBarHidden(true, animated: false)
        chromerivalsControllers[1].setNavigationBarHidden(true, animated: false)
        
        self.setViewControllers(chromerivalsControllers, animated: false)
        self.tabBar.toCRTabBar()
        
        guard let items = self.tabBar.items else { return }
        items[0].image = UIImage(named: "home")
        items[1].image = UIImage(named: "search")
    }

    
    
}

extension UITabBar {
    
    func toCRTabBar() {
        self.tintColor = UIColor.CRPrimaryColor()
        self.barTintColor = UIColor.CRGrayColor()
    }
    
}
