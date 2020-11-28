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
                             updateInformation: @escaping (IndexPath) -> ())
    
    func showDatePicker(updateInformation: @escaping (IndexPath) -> ())
    
    func petInfoForModel() -> String?
    
    func fetchTableInfo(tableView: UITableView,
                        indexPath: IndexPath)
}
