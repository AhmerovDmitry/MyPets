//
//  @objc PetViewControllerExtension.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.10.2020.
//

import UIKit

@objc
extension PetViewController {
    func presentController() {
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        
        let petInfoVC = PetInfoViewController()
        petInfoVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(petInfoVC, animated: true)
    }
}
