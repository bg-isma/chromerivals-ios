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

        for (index, _) in chromerivalsControllers.enumerated() {
            chromerivalsControllers[index].setNavigationBarHidden(true, animated: false)
        }
        
        chromerivalsControllers[0].title = "Events"
        chromerivalsControllers[1].title = "Search"
        
        self.setViewControllers(chromerivalsControllers, animated: false)
        self.tabBar.toCRTabBar()
        
        guard let items = self.tabBar.items else { return }
        items[0].image = UIImage(named: "home")
        items[1].image = UIImage(named: "search")
    }

}
