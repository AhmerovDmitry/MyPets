//
//  UIViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.01.2021.
//

import UIKit

extension UIViewController {
    /// Present premium view controller for pay full app version
    func presentPremiumController(on controller: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window?.layer.add(transition, forKey: kCATransition)
        
        let premiumVC = PremiumViewController()
        controller.view.addSubview(premiumVC.view)
        controller.addChild(premiumVC)
        premiumVC.didMove(toParent: controller)
    }
}
