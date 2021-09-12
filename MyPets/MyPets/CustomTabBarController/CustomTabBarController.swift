//
//  CustomTabBarController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.10.2020.
//

import UIKit

final class CustomTabBarController: UITabBarController {
    
    // MARK: - Services
    let storageService: StorageServiceProtocol
    let userDefaultsService: UserDefaultsServiceProtocol

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
        // Тут начинается загрузка данных из CoreData для ускорения обработки данных
        storageService.loadEntitys()

        setupControllers()
        presentPremium()
    }
}

// MARK: - Setup UI
extension CustomTabBarController {
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

        let locationVC = LocationViewController()
        locationVC.tabBarItem.title = "Места"
        locationVC.tabBarItem.image = UIImage(named: "locationIcon")

//        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        let profileVC = UINavigationController(
            rootViewController: ProfileController(storageService: storageService,userDefaultsService: userDefaultsService)
        )
        profileVC.tabBarItem.title = "Профиль"
        profileVC.tabBarItem.image = UIImage(named: "profileIcon")

        tabBar.backgroundColor = .white
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.unselectedItemTintColor = UIColor.CustomColor.gray
        tabBar.tintColor = UIColor.CustomColor.purple

        viewControllers = [mainVC, petVC, locationVC, profileVC]
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
