//
//  CustomTabBarController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.10.2020.
//

import UIKit

final class CustomTabBarController: UITabBarController {

    // MARK: - Property

    let storageService: StorageService
    let userDefaultsService: UserDefaultsService

    init(storageService: StorageService, userDefaultsService: UserDefaultsService) {
        self.storageService = storageService
        self.userDefaultsService = userDefaultsService
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - Init / Lifecycle

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        presentPremium()
        setupTabBarSettings()
    }

    // MARK: - UI

    private func setupTabBarSettings() {
        tabBar.backgroundColor = .white
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.unselectedItemTintColor = UIColor.CustomColor.gray
        tabBar.tintColor = UIColor.CustomColor.purple
    }
    private func setupControllers() {
        let mainVC = UINavigationController(rootViewController: MainMenuController())
        mainVC.tabBarItem.title = "Главная"
        mainVC.tabBarItem.image = UIImage(named: "generalIcon")

        let petVC = UINavigationController(
            rootViewController: PetMenuController(storageService: storageService,
                                                  userDefaultsService: userDefaultsService)
        )
        petVC.tabBarItem.title = "Питомцы"
        petVC.tabBarItem.image = UIImage(named: "petIcon")

        let profileVC = UINavigationController(
            rootViewController: ProfileController(storageService: storageService,
                                                  userDefaultsService: userDefaultsService)
        )
        profileVC.tabBarItem.title = "Профиль"
        profileVC.tabBarItem.image = UIImage(named: "profileIcon")

        viewControllers = [mainVC, petVC, profileVC]
    }
}

// MARK: - Methods

extension CustomTabBarController {

    /// Метод показывающий преимум контроллер если покупка не совершена
    /// Возможно отключение показа контроллера нажатием на кнопку-заглушку "Купить Premium"

    private func presentPremium() {
        if !userDefaultsService.value(forKey: .isAppPurchased) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                guard let self = self else { return }
                let premiumController = PremiumController(userDefaultsService: self.userDefaultsService)
                premiumController.modalPresentationStyle = .fullScreen
                self.present(premiumController, animated: true, completion: nil)
            }
        }
    }
}
