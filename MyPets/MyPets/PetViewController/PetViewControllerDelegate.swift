//
//  PetViewControllerDelegate.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 31.10.2020.
//

import UIKit

protocol PetViewControllerDelegate: class {
    func showAlertController()
}

protocol PetViewCollectionDelegate: class {
    func functionTransfer()
}
