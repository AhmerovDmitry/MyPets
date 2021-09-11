//
//  PetMenuController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.08.2021.
//

import UIKit

protocol PetMenuControllerDelegate: AnyObject {
    func reloadController()
}

final class PetMenuController: UIViewController {

    // MARK: - Properties
    private let storageService: StorageServiceProtocol

    private lazy var petMenuView = PetMenuView(frame: view.bounds)
    private lazy var petCollectionView = PetCollectionView(frame: view.bounds)

    private var tappedCellIndex: Int?

    // MARK: - Initialization
    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        petCollectionView.collectionViewDelegate(self)
        petCollectionView.collectionViewDataSource(self)
        setCallBacksTransfers()
        setupNavigationController()
        addSubview()
    }
}
// MARK: - Methods
extension PetMenuController {
    private func setCallBacksTransfers() {
        petMenuView.presentControllerCallBack = { [weak self] in
            self?.presentController()
        }
    }
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.CustomColor.dark]
        navigationItem.title = "Питомцы"
        guard let image = UIImage(systemName: "plus") else { return }
        let addButton = UIBarButtonItem(image: image, style: .done,
                                        target: self, action: #selector(presentController))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.rightBarButtonItem?.tintColor = UIColor.CustomColor.purple

        guard let trashImage = UIImage(systemName: "trash") else { return }
        let removeFirstButton = UIBarButtonItem(image: trashImage, style: .done,
                                                target: self, action: #selector(removeFirstObject))
        navigationItem.leftBarButtonItem = removeFirstButton
        navigationItem.leftBarButtonItem?.tintColor = UIColor.CustomColor.purple
    }
    /// Если в CoreData нет объектов тогда грузится экран с кнопкой "Добавить питомца"
    /// в обратном случае грузится экран с коллекцией (списком объектов)
    private func addSubview() {
        storageService.objects.isEmpty ? view.addSubview(petMenuView) : view.addSubview(petCollectionView)
    }
}
// MARK: - Actions
extension PetMenuController {
    @objc private func presentController() {
        let controller = PetInfoController(storageService: storageService, collectionCellIndex: tappedCellIndex)
        controller.delegate = self
        /// Сбрасываю индекс чтобы он не сохранялся при повторном открытии экрана без использования ячеек,
        /// открытие окна с помощью кнопки "+"
        tappedCellIndex = nil
        navigationController?.pushViewController(controller, animated: true)
    }
    @objc func removeFirstObject() {
        if !storageService.objects.isEmpty {
            storageService.removeEntity(at: 0)
            petCollectionView.reloadCollectionView()
        } else {
            reloadController()
        }
    }
}
// MARK: - Delegate & DataSource
extension PetMenuController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width / 1.11111, height: view.bounds.height / 3.5)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storageService.objects.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: petCollectionView.cellID,
            for: indexPath
        ) as? PetCollectionCell else { return UICollectionViewCell() }
        cell.configureCell(image: storageService.loadPhoto(photoId: indexPath.row),
                           name: storageService.objects[indexPath.row].name ?? "Кличка не указана",
                           breed: storageService.objects[indexPath.row].breed ?? "Порода не указана",
                           age: storageService.objects[indexPath.row].birthday ?? "01.01.1001")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tappedCellIndex = indexPath.row
        presentController()
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
}
extension PetMenuController: PetMenuControllerDelegate {
    func reloadController() {
        self.petCollectionView.reloadCollectionView()
        self.addSubview()
    }
}
