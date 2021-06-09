//
//  @objc PremiumViewControllerExtension.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 14.10.2020.
//

import UIKit

@objc
extension PremiumViewController {
    
    @objc func closeController() {
//        UIView.animate(withDuration: 0.5) {
//            let transition = CATransition()
//            transition.duration = 0.5
//            transition.type = CATransitionType.push
//            transition.subtype = CATransitionSubtype.fromLeft
//            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
//            self.view.window!.layer.add(transition, forKey: kCATransition)
//        } completion: { _ in
//            self.willMove(toParent: nil)
//            self.view.removeFromSuperview()
//            self.removeFromParent()
//        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func presentController() {
        print("Show Pay Controller!")
    }
    
}
