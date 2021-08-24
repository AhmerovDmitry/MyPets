//
//  PetMenuController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.08.2021.
//

import UIKit

final class PetMenuController: UIViewController {
    // MARK: - Properties
    private let petBadgeModel = PetBadge()
    private let petMenuView = PetMenuView(frame: UIScreen.main.bounds)
    private let petCollectionView = PetCollectionView(frame: UIScreen.main.bounds)
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        petCollectionView.getPetCollectionContent(petBadgeModel)
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
        petCollectionView.presentControllerCallBack = { [weak self] _ in
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
    private func addSubview() {
        view.addSubview(petCollectionView)
//        view.addSubview(petMenuView)
    }
}
// MARK: - Actions
extension PetMenuController {
    @objc private func presentController() {
        self.openControllerWithoutBackBarItemTitle(PetInfoController())
    }
}
