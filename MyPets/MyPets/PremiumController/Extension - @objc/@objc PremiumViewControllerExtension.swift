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
        let authorizationVC = AuthorizationViewController()
        authorizationVC.modalPresentationStyle = .fullScreen
        present(authorizationVC, animated: true, completion: nil)
    }
    
    @objc func presentController() {
        print("Show Pay Controller!")
    }
}
