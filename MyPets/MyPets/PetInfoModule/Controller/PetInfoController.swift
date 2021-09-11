//
//  PetInfoController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.08.2021.
//

import UIKit

protocol TransferPetInformationDelegate: AnyObject {
    func transferPetInformation(_ information: String?)
}

final class PetInfoController: UIViewController {

    // MARK: - Properties
    weak var delegate: PetMenuControllerDelegate?
    private var petModel: PetInfoModel
    private var petInfoView: PetInfoView
    private var collectionCellIndex: Int?
    private var selectedTableCell: IndexPath?

    // MARK: - Initialization
    init(storageService: StorageServiceProtocol, collectionCellIndex: Int?) {
        self.petModel = PetInfoModel(storageService: storageService, cellIndex: collectionCellIndex)
        self.petInfoView = PetInfoView(frame: UIScreen.main.bounds)
        self.collectionCellIndex = collectionCellIndex
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
            action: #selector(changePetPhoto)
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
        switch index {
        case 0: cell.configurePlaceholder(petModel.objectForFilling.name)
        case 1: cell.configurePlaceholder(petModel.objectForFilling.kind)
        case 2: cell.configurePlaceholder(petModel.objectForFilling.breed)
        case 3: cell.configurePlaceholder(petModel.objectForFilling.birthday)
        case 4: cell.configurePlaceholder(petModel.objectForFilling.weight)
        case 5: cell.configurePlaceholder(petModel.objectForFilling.sterile)
        case 6: cell.configurePlaceholder(petModel.objectForFilling.color)
        case 7: cell.configurePlaceholder(petModel.objectForFilling.hair)
        case 8: cell.configurePlaceholder(petModel.objectForFilling.chipNumber)
        default: break
        }
        petInfoView.setPetPhoto(petModel.loadPhoto())
    }

    /// Метод открытия контроллера ввода информации
    /// в него передается информация которую пользователь вводил или nil
    private func presentInputInfoController(index: Int) {
        let controller = InputInfoController()
        switch index {
        case 0: controller.checkTextField(petModel.objectForFilling.name)
        case 1: controller.checkTextField(petModel.objectForFilling.kind)
        case 2: controller.checkTextField(petModel.objectForFilling.breed)
        case 3: controller.checkTextField(petModel.objectForFilling.birthday)
        case 4: controller.checkTextField(petModel.objectForFilling.weight)
        case 5: controller.checkTextField(petModel.objectForFilling.sterile)
        case 6: controller.checkTextField(petModel.objectForFilling.color)
        case 7: controller.checkTextField(petModel.objectForFilling.hair)
        case 8: controller.checkTextField(petModel.objectForFilling.chipNumber)
        default: break
        }
        controller.delegate = self
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
    }
}

// MARK: - Actions
/// Сохранение / удаление модели
extension PetInfoController {

    /// Переходим на предыдущий контроллер сохраняя модель в CoreData
    @objc private func popToViewControllerAndSaveEntity() {
        if !petModel.isObjectNil() {
            if let index = collectionCellIndex {
                petModel.editedObject(at: index)
            } else {
                petModel.saveObject()
            }
            delegate?.reloadController()
        }
        navigationController?.popViewController(animated: true)
    }

    /// Загрузка фотографии из библиотеки
    @objc private func changePetPhoto() {
        let photoGallery = UIImagePickerController()
        photoGallery.allowsEditing = true
        photoGallery.sourceType = .photoLibrary
        photoGallery.delegate = self
        present(photoGallery, animated: true, completion: nil)
    }
}

// MARK: - Delegate & DataSource
extension PetInfoController: TransferPetInformationDelegate {
    /// Метод получающий текст который вводит пользователь на экране ввода информации,
    /// после этого введенный текст передается в модель
    /// и ячейка таблицы перезагружается для обновления текста
    /// - Parameter information: Данные, которые вводит пользователь
    func transferPetInformation(_ information: String?) {
        if let indexCell = selectedTableCell  {
            petModel.changeObjectInformation(at: indexCell.row, information)
            petInfoView.reloadTableViewCell(at: indexCell)
            selectedTableCell = nil
        }
    }
}

// MARK: - Delegate и DataSource для коллекции
extension PetInfoController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0: return CGSize(width: UIView.ninePartsScreenMultiplier,
                              height: view.bounds.height / 1.7)
        default: return CGSize(width: UIView.ninePartsScreenMultiplier,
                               height: view.bounds.height / 9)
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

// MARK: - Delegate и DataSource для таблицы в которой заполняется информация о питомце
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
        presentInputInfoController(index: indexPath.row)
        selectedTableCell = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension PetInfoController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        petInfoView.setPetPhoto(image)
        petModel.changeObjectPhoto(image)
        dismiss(animated: true, completion: nil)
    }
}
