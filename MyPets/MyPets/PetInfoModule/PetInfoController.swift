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

protocol TransferPetBirthdayDelegate: AnyObject {
    func transferPetBirthday(_ information: String)
}

final class PetInfoController: UIViewController {

    // MARK: - Property

    weak var delegate: PetMenuControllerDelegate?
    private var petModel: PetInfoModelImpl
    private var petInfoView: PetInfoView
    private var collectionCellIndex: Int?
    private var selectedTableCell: IndexPath?

    // MARK: - Init / Lifecycle

    init(storageService: StorageServiceProtocol, collectionCellIndex: Int?) {
        self.petModel = PetInfoModelImpl(storageService: storageService, cellIndex: collectionCellIndex)
        self.petInfoView = PetInfoView(frame: UIScreen.main.bounds)
        self.collectionCellIndex = collectionCellIndex
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        view = petInfoView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        petInfoView.collectionViewDelegate(self)
        petInfoView.collectionViewDataSource(self)
        petInfoView.tableViewDelegateAndDataSource(self)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveObject()
        popToViewController()
    }

    // MARK: - UI

    private func setupNavigationController() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "camera"),
            style: .done, target: self, action: #selector(changePetPhoto)
        )
        navigationItem.rightBarButtonItem?.tintColor = UIColor.CustomColor.purple

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.uturn.left"),
            style: .done, target: self, action: #selector(popToViewController)
        )
        navigationItem.leftBarButtonItem?.tintColor = UIColor.CustomColor.purple
    }

    // MARK: - Methods

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
        if index == 3 {
            let controller = DatePickerController()
            controller.setDate(petModel.objectForFilling.birthday ?? "")
            controller.delegate = self
            controller.modalPresentationStyle = .overFullScreen
            controller.modalTransitionStyle = .crossDissolve
            present(controller, animated: true, completion: nil)
        } else {
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
}

/// Сохранение / удаление модели
extension PetInfoController {
    /// Переходим на предыдущий контроллер
    @objc private func popToViewController() {
        delegate?.reloadController()
        navigationController?.popViewController(animated: true)
    }
    /// Сохраняем объект
    /// Загрузка фотографии из библиотеки
    func saveObject() {
        // Пользователь зашел впервые
        if collectionCellIndex == nil {
            // И нормально заполнил модель
            if !petModel.isObjectNil() {
                petModel.saveObject()
            }
            // Пользователь зашел не впервые
        } else if let index = collectionCellIndex {
            // И убрал все поля из модели
            if petModel.isObjectNil() {
                petModel.removeObject(at: index)
                // Отредактировал модель и оставил поля
            } else {
                petModel.editedObject(at: index)
            }
        }
    }
    @objc private func changePetPhoto() {
        let photoGallery = UIImagePickerController()
        photoGallery.allowsEditing = true
        photoGallery.sourceType = .photoLibrary
        photoGallery.delegate = self
        present(photoGallery, animated: true, completion: nil)
    }
}

extension PetInfoController: TransferPetInformationDelegate, TransferPetBirthdayDelegate {

    /// Метод получающий текст который вводит пользователь на экране ввода информации,
    /// после этого введенный текст передается в модель
    /// и ячейка таблицы перезагружается для обновления текста
    /// - Parameter information: Данные, которые вводит пользователь

    func transferPetInformation(_ information: String?) {
        if let indexCell = selectedTableCell {
            petModel.changeObjectInformation(at: indexCell.row, information)
            petInfoView.reloadTableViewCell(at: indexCell)
            selectedTableCell = nil
        }
    }

    /// Метод обновления даты рождения питомца
    /// - Parameter information: Данные которые ввел пользователь

    func transferPetBirthday(_ information: String) {
        if let indexCell = selectedTableCell {
            petModel.changeObjectInformation(at: indexCell.row, information)
            petInfoView.reloadTableViewCell(at: indexCell)
            selectedTableCell = nil
        }
    }
}

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
        2
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

extension PetInfoController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        petInfoView.setPetPhoto(image)
        petModel.changeObjectPhoto(image)
        dismiss(animated: true, completion: nil)
    }
}
