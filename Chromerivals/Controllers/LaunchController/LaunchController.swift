//
//  LaunchController.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 26/3/22.
//

import UIKit
import Lottie

class LaunchController: UIViewController {


    @IBOutlet weak var splashAnimationView: UIView!
    
    init() {
        super.init(nibName: "LaunchView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = AnimationView(name: "chrome_splash")
        
        animationView.frame = splashAnimationView.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.8
        animationView.play()
        splashAnimationView.addSubview(animationView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let mainController = MainNavigationController()
            self.navigationController?.pushViewController(mainController, animated: true)
        }
        
    }
    
}
