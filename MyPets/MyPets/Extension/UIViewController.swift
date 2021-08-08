//
//  UIViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.01.2021.
//

import UIKit

extension UIViewController {
    func presentPremiumController(parent controller: UIViewController?) {
        let premiumVC = PremiumController()
        premiumVC.modalPresentationStyle = .fullScreen
        controller?.present(premiumVC, animated: true, completion: nil)
    }
    
    func pushView(controller: UIViewController, withTitle: String) {
        controller.navigationController?.navigationBar.tintColor = UIColor.CustomColor.dark
        controller.navigationController?.navigationBar.prefersLargeTitles = true
        controller.navigationController?.navigationBar.backgroundColor = .clear
        controller.navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.CustomColor.dark
        ]
        controller.navigationItem.title = withTitle
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func setupBackBarItem() {
        let backItem = UIBarButtonItem()
        backItem.title = " "
        self.navigationItem.backBarButtonItem = backItem
    }
}
