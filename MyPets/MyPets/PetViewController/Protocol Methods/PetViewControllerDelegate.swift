//
//  PetViewControllerDelegate.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 31.10.2020.
//

import UIKit

protocol PetTableViewDelegate: class {
    func reloadTableView(_ tableView: UITableView)
    func fetchCellIndexPath(_ indexPath: IndexPath)
}

protocol PetViewControllerDelegate: class {
    func showAlertController(title: String,
                             message: String)
    func showDatePicker()
//    func updatePetInfo(updateInformation: @escaping (IndexPath) -> ())
//    func petInfoForModel() -> String?
//    func fetchTableInfo(tableView: UITableView,
//                        indexPath: IndexPath,
//                        updateInformation: @escaping (IndexPath) -> ())
    func fetchIndexPath(_ indexPath: IndexPath)
    func fetchTableView(_ tableView: UITableView)
}

protocol EntityTransfer: class {
    func reloadCollectionView()
    func createEntity(_ entity: PetModel)
    func reloadController()
    func updateEntity(_ entity: PetModel, at indexPath: Int)
    func loadPets()
    func deleteEntity(at index: Int)
}
