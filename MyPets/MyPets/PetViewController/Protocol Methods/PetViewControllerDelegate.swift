//
//  PetViewControllerDelegate.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 31.10.2020.
//

import UIKit

protocol PetViewControllerDelegate: AnyObject {
    func showAlertController(title: String,
                             message: String)
    func showDatePicker()
    func updatePetInfo(updateInformation: @escaping (IndexPath) -> Void)
    func petInfoForModel() -> String?
    func getTableView(_ tableView: UITableView)
    func getCellInfo(indexPath: IndexPath, updateInformation: @escaping (IndexPath) -> Void)
}

protocol EntityTransfer: AnyObject {
    func reloadCollectionView()
    func reloadController()
    func loadPets()
    func createEntity(_ entity: Any)
    func updateEntity(_ entity: Any, at index: Int)
    func deleteEntity(at index: Int)
}
