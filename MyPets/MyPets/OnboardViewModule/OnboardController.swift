//
//  OnboardController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 03.08.2021.
//

import UIKit

// MARK: - Delegate

protocol OnboardControllerDelegate: AnyObject {
    func presentTabBarController()
    func collectionViewDelegateAndDataSource(_ collection: UICollectionView)
}

final class OnboardController: UIViewController {

    // MARK: - Property

    let storageService: StorageService
    let userDefaultsService: UserDefaultsService

    private let onboardModel: OnboardModelProtocol
    private let onboardView: OnboardView

    // MARK: - Init / Lifecycle

    init(storageService: StorageService, userDefaultsService: UserDefaultsService) {
        self.storageService = storageService
        self.userDefaultsService = userDefaultsService
        self.onboardModel = OnboardModel()
        self.onboardView = OnboardView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        view = onboardView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onboardView.delegate = self
        onboardView.collectionViewDelegateAndDataSource(self)
        onboardView.setPageControl(countPage: onboardModel.description.count)
    }
}

// MARK: - Delegate Methods

extension OnboardController: OnboardControllerDelegate {
    func collectionViewDelegateAndDataSource(_ collection: UICollectionView) {
        collection.delegate = self
        collection.dataSource = self
    }
    func presentTabBarController() {
        let tabBarController = CustomTabBarController(storageService: storageService,
                                                      userDefaultsService: userDefaultsService)
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true, completion: nil)
        userDefaultsService.setValue(true, forKey: .isNotFirstLaunch)
    }
}

extension OnboardController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardModel.description.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: onboardView.cellID, for: indexPath
        ) as? OnboardCollectionCell else { return UICollectionViewCell() }
        cell.configureCell(image: onboardModel.imagesName[indexPath.row],
                           description: onboardModel.description[indexPath.row])
        return cell
    }
}
