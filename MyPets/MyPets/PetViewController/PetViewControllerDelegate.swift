//
//  PetViewControllerDelegate.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 31.10.2020.
//

import UIKit

protocol PetViewControllerDelegate: class {
    func showAlertController(title: String,
                             message: String,
                             tableView: UITableView,
                             indexPath: IndexPath,
                             updateInformation: @escaping (IndexPath) -> ())
    func petInfoForModel() -> String?
}
