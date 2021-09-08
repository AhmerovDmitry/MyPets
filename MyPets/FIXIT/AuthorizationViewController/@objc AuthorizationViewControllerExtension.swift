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
        let tabBarController = CustomTabBarController()
//        tabBarController.viewControllers = tabBarController.controllers
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true, completion: nil)
    }
}
