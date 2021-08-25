//
//  PetInfoController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.08.2021.
//

import UIKit

protocol TransferPetInformationDelegate: AnyObject {
    func transferPetInformation(_ information: String)
}

final class PetInfoController: UIViewController {
    // MARK: - Properties
    weak var delegate: PetMenuControllerDelegate?
    private var collectionCellIndex: Int? {
        didSet {
            if let index = collectionCellIndex {
                petModel.loadEntity(at: index)
            }
        }
    }
    private var cellIndex: IndexPath?
    private var petModel = PetInfoModel()
    private lazy var petInfoView = PetInfoView(frame: view.frame)
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(petInfoView)
        setupNavigationController()
        petInfoView.collectionViewDelegate(self)
        petInfoView.collectionViewDataSource(self)
        petInfoView.tableViewDelegateAndDataSource(self)
    }
}
// MARK: - Methods
extension PetInfoController {
    private func setupNavigationController() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "camera"),
            style: .done,
            target: self,
            action: #selector(popToViewControllerAndDeleteEntity)
        )
        navigationItem.rightBarButtonItem?.tintColor = UIColor.CustomColor.dark
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.uturn.left"),
            style: .done,
            target: self,
            action: #selector(popToViewControllerAndSaveEntity)
        )
        navigationItem.leftBarButtonItem?.tintColor = UIColor.CustomColor.dark
    }
    /// Метод конфигурирования ячейки
    /// задается тайтл и плейсхолдер (все берется из модели)
    private func configureCell(_ cell: PetInfoTableCell, index: Int) {
        cell.configureTitle(petModel.menuTitles[index])
        cell.configurePlaceholder(petModel.petInformation[index])
    }
    /// Метод открытия контроллера ввода информации
    /// в него передается информация которую пользователь вводил или nil
    private func presentInputInfoController() {
        if let index = cellIndex?.row {
            let controller = InputInfoController()
            controller.checkTextField(petModel.petInformation[index])
            controller.delegate = self
            controller.modalPresentationStyle = .overFullScreen
            controller.modalTransitionStyle = .crossDissolve
            present(controller, animated: true, completion: nil)
        }
    }
    /// Перезагрузка ячейки таблицы
    private func reloadTableViewCell() {
        if let cellIndex = cellIndex {
            petInfoView.reloadTableViewCell(at: cellIndex)
        }
    }
}
// MARK: - Actions
/// Сохранение / удаление модели
extension PetInfoController {
    /// Переходим на предыдущий контроллер сохраняя модель в CoreData
    @objc private func popToViewControllerAndSaveEntity() {
        petModel.saveEntityInCoreData()
        delegate?.reloadController()
        navigationController?.popViewController(animated: true)
    }
    /// Удаляем выбранный объект и переходим на предыдущий экран
    @objc private func popToViewControllerAndDeleteEntity() {
        guard let index = collectionCellIndex else { return }
        petModel.removeEntityFromCoreData(at: index)
        delegate?.reloadController()
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Delegate & DataSource
extension PetInfoController: TransferPetInformationDelegate {
    /// Метод получающий текст который вводит пользователь на экране ввода информации,
    /// после этого введенный текст передается в модель
    /// и ячейка таблицы перезагружается для обновления текста
    public func transferPetInformation(_ information: String) {
        if let cellIndex = cellIndex {
            petModel.updateInformation(information, index: cellIndex.row)
            reloadTableViewCell()
        }
    }
}
/// Delegate и DataSource для коллекции
extension PetInfoController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0: return CGSize(width: view.bounds.width / 1.1, height: view.bounds.height / 1.7)
        default: return CGSize(width: view.bounds.width / 1.1, height: view.bounds.height / 9)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: petInfoView.collectionCellID,
            for: indexPath
        ) as? PetInfoCollectionCell else { return UICollectionViewCell() }
        indexPath.row == 0 ? petInfoView.setPetInfoCollectionInCell(cell) : nil
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: view.bounds.height / 9, left: 0, bottom: 15, right: 0)
    }
}
/// Delegate и DataSource для таблицы в которой заполняется информация о питомце
extension PetInfoController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / CGFloat(petModel.menuTitles.count)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petModel.menuTitles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: petInfoView.tableCellID,
            for: indexPath
        ) as? PetInfoTableCell else { return UITableViewCell() }
        configureCell(cell, index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellIndex = indexPath
        presentInputInfoController()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Public Methods
extension PetInfoController {
    /// Метод принимающий нажатую ячейку для получения нужной модели (удаление / загрузка)
    public func getCellIndex(_ index: Int?) {
        collectionCellIndex = index
    }
}
