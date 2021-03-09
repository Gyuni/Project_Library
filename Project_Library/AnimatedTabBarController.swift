//
//  AnimatedTabBarController.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/10.
//

import UIKit

class AnimatedTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        guard let barButtonView = item.value(forKey: "view") as? UIView else { return }
                
            let animationLength: TimeInterval = 0.3
            let propertyAnimator = UIViewPropertyAnimator(duration: animationLength, dampingRatio: 0.5) {
                barButtonView.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
            }
            propertyAnimator.addAnimations({ barButtonView.transform = .identity }, delayFactor: CGFloat(animationLength))
            propertyAnimator.startAnimation()
    }

}
