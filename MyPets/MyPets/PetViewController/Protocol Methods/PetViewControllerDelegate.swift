//
//  PetViewControllerDelegate.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 31.10.2020.
//

import UIKit

protocol PetViewControllerDelegate: class {
    func showAlertController(title: String,
                             message: String)
    func showDatePicker()
    func updatePetInfo(updateInformation: @escaping (IndexPath) -> ())
    func petInfoForModel() -> String?
    func getTableView(_ tableView: UITableView)
    func getCellInfo(indexPath: IndexPath, updateInformation: @escaping (IndexPath) -> ())
//    func fetchTableInfo(tableView: UITableView,
//                        indexPath: IndexPath,
//                        updateInformation: @escaping (IndexPath) -> ())
}

protocol EntityTransfer: class {
    func reloadCollectionView()
    func createEntity(_ entity: PetModel)
    func reloadController()
    func updateEntity(_ entity: PetModel, at indexPath: Int)
    func loadPets()
    func deleteEntity(at index: Int)
}
