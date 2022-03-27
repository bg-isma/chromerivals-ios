//
//  LaunchController.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 26/3/22.
//

import UIKit
import Lottie

class LaunchController: UIViewController {


    @IBOutlet weak var splashAnimationView: LOTAnimationView!
    
    init() {
        super.init(nibName: "LaunchView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Set animation content mode
        splashAnimationView.contentMode = .scaleAspectFit
        
        // 2. Set animation loop mode
        splashAnimationView.loopAnimation = true
        
        // 3. Adjust animation speed
        splashAnimationView.animationSpeed = 0.8
        
        // 4. Play animation
        splashAnimationView.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let mainController = MainNavigationController()
            self.navigationController?.pushViewController(mainController, animated: true)
        }
        
    }
    
}
