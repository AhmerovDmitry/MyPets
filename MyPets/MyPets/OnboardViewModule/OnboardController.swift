//
//  OnboardController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 03.08.2021.
//

import UIKit

final class OnboardController: UIViewController {

    // MARK: - Properties
    let storageService: StorageServiceProtocol
    let userDefaultsService: UserDefaultsServiceProtocol

    private let onboardContent = OnboardModel()
    private let onboardView = OnboardView(frame: UIScreen.main.bounds)

    // MARK: - Lifecycle
    init(storageService: StorageServiceProtocol, userDefaultsService: UserDefaultsServiceProtocol) {
        self.storageService = storageService
        self.userDefaultsService = userDefaultsService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewContent()
        addOnboardViewInHierarchy()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onboardView.presentControllerCallBack = { [weak self] in
            guard let self = self else { return }
            let tabBarController = CustomTabBarController(storageService: self.storageService,
                                                          userDefaultsService: self.userDefaultsService)
            tabBarController.modalPresentationStyle = .fullScreen
            self.present(tabBarController, animated: true, completion: nil)
            self.userDefaultsService.setValue(true, forKey: .isNotFirstLaunch)
        }
    }
}

// MARK: - Methods
extension OnboardController {
    private func updateViewContent() {
        onboardView.getOnboardContent(onboardContent)
    }
    private func addOnboardViewInHierarchy() {
        view.addSubview(onboardView)
    }
}