//
//  @objc PetViewControllerExtension.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.10.2020.
//

import UIKit

@objc
extension MainPetViewController {
    func presentController() {
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        
        let petInfoVC = PetInfoViewController()
        petInfoVC.hidesBottomBarWhenPushed = true
        petInfoVC.delegate = self
        navigationController?.pushViewController(petInfoVC, animated: true)
    }
}
