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
        petInfoVC.petEntity = PetModel(image: nil, name: nil, kind: nil, breed: nil,
                                       birthday: nil, weight: nil, sterile: nil, color: nil,
                                       hair: nil, chipNumber: nil)
        petInfoVC.delegate = self
        navigationController?.pushViewController(petInfoVC, animated: true)
    }
}
