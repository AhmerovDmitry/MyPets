//
//  OnboardController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 03.08.2021.
//

import UIKit

final class OnboardController: UIViewController {
    let storageService: StorageService
    let userDefaultsService: UserDefaultsService

    private let onboardModel: OnboardModelProtocol
    private let onboardView = OnboardView(frame: UIScreen.main.bounds)

    init(storageService: StorageService, userDefaultsService: UserDefaultsService) {
        self.storageService = storageService
        self.userDefaultsService = userDefaultsService
        self.onboardModel = OnboardModel()
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
        updateViewContent()
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

extension OnboardController {
    private func updateViewContent() {
        onboardView.getOnboardContent(onboardModel)
    }
}
