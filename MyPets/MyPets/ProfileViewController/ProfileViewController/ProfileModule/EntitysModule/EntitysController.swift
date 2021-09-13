//
//  EntitysController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.09.2021.
//

import UIKit

final class EntitysController: UIViewController {
    private var entitysModel: EntitysModel
    private var entitysView: EntitysView
    private let entitysTableViewCellID = "entitysTableViewCellID"

    init(storageService: StorageServiceProtocol) {
        self.entitysModel = EntitysModel(storageService: storageService)
        self.entitysView = EntitysView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = entitysView
        entitysView.tableViewDelegateAndDataSource(self)
        entitysView.setTableViewID(entitysTableViewCellID)
        setupNavigationController()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        popViewController()
    }
}

extension EntitysController {
    private func setupNavigationController() {
        navigationItem.title = "Список питомцев"

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.uturn.left"),
            style: .done,
            target: self,
            action: #selector(popViewController)
        )
        navigationItem.leftBarButtonItem?.tintColor = UIColor.CustomColor.purple
    }

    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension EntitysController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        entitysModel.getObjects().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: entitysTableViewCellID, for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: entitysTableViewCellID)
        cell.textLabel?.tintColor = UIColor.CustomColor.darkGray
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.text = entitysModel.getObjects()[indexPath.row].name ?? entitysModel.defaultName
        cell.detailTextLabel?.text = entitysModel.getObjects()[indexPath.row].breed ?? entitysModel.defaultBreed
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        entitysModel.removeObject(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.reloadData()
        if entitysModel.getObjects().count == 0 { popViewController() }
    }

}

