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
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.type = CATransitionType.push
//        transition.subtype = CATransitionSubtype.fromRight
//        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
//        view.window?.layer.add(transition, forKey: kCATransition)
        
//        controller.view.addSubview(premiumVC.view)
//        controller.addChild(premiumVC)
//        premiumVC.didMove(toParent: controller)
        
        let premiumVC = PremiumViewController()
        premiumVC.modalPresentationStyle = .fullScreen
        controller.present(premiumVC, animated: true, completion: nil)
    }
    
    func pushView(controller: UIViewController, withTitle: String) {
        controller.navigationController?.navigationBar.tintColor = UIColor.CustomColor.dark
        controller.navigationController?.navigationBar.prefersLargeTitles = true
        controller.navigationController?.navigationBar.backgroundColor = .clear
        controller.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.CustomColor.dark]
        controller.navigationItem.title = withTitle
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func setupBackBarItem() {
        let backItem = UIBarButtonItem()
        backItem.title = " "
        self.navigationItem.backBarButtonItem = backItem
    }
}
