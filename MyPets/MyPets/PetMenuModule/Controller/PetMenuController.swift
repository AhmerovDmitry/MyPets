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
    private var tappedCellIndex: Int?
    private lazy var petMenuView = PetMenuView(frame: view.bounds)
    private lazy var petCollectionView = PetCollectionView(frame: view.bounds)
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
        let addButton = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(presentController))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.rightBarButtonItem?.tintColor = UIColor.CustomColor.purple
    }
    /// Если в CoreData нет питомцев тогда грузится экран с кнопкой "Добавить питомца"
    /// в обратном случае грузится экран с коллекцией (списком питомцев)
    private func addSubview() {
        CoreDataManager.shared.pets.isEmpty ? view.addSubview(petMenuView) : view.addSubview(petCollectionView)
    }
}
// MARK: - Actions
extension PetMenuController {
    @objc private func presentController() {
        let controller = PetInfoController()
        controller.delegate = self
        controller.getCellIndex(tappedCellIndex)
        /// Сбрасываю индекс чтобы он не сохранялся при повторном открытии экрана без использования ячеек,
        /// открытие окна с помощью кнопки "+"
        tappedCellIndex = nil
        navigationController?.pushViewController(controller, animated: true)
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
        return CoreDataManager.shared.pets.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: petCollectionView.cellID,
            for: indexPath
        ) as? PetCollectionCell else { return UICollectionViewCell() }
        cell.configureCell(
            image: UIImage(),
            name: CoreDataManager.shared.pets[indexPath.row].name ?? "Кличка не указана",
            breed: CoreDataManager.shared.pets[indexPath.row].breed ?? "Порода не указана",
            age: CoreDataManager.shared.pets[indexPath.row].birthday ?? "01.01.1001"
        )
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
