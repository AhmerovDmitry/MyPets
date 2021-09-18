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

    init(storageService: StorageService) {
        self.entitysModel = EntitysModel(storageService: storageService)
        self.entitysView = EntitysView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        view = entitysView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        entitysView.tableViewDelegateAndDataSource(self)
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.uturn.left"), style: .done,
                                                           target: self, action: #selector(popViewController))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.CustomColor.purple
    }
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    private func updateCellContent(_ cell: UITableViewCell, index: Int) {
        cell.textLabel?.tintColor = UIColor.CustomColor.darkGray
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.text = entitysModel.getObjects()[index].name ?? entitysModel.defaultName
        cell.detailTextLabel?.text = entitysModel.getObjects()[index].breed ?? entitysModel.defaultBreed
    }
}

extension EntitysController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        entitysModel.getObjects().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: entitysView.entitysTableViewCellID, for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: entitysView.entitysTableViewCellID)
        updateCellContent(cell, index: indexPath.row)
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
        if entitysModel.getObjects().isEmpty { popViewController() }
    }
}
