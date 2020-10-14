//
//  @objc AuthorizationViewControllerExtension.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.10.2020.
//

import UIKit

@objc
extension AuthorizationViewController {
    func presentController() {
        let tabBarController = UITabBarController()
        let mainVC = MainViewController()
        let mainNavVC = UINavigationController(rootViewController: mainVC)
        let controllers = [mainNavVC]
        
        tabBarController.viewControllers = controllers
        tabBarController.modalPresentationStyle = .fullScreen

        present(tabBarController, animated: true, completion: nil)
    }
}
