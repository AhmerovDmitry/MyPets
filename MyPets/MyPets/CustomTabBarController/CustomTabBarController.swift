//
//  CustomTabBarController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.10.2020.
//

import UIKit

final class CustomTabBarController: UITabBarController {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        presentPremium()
    }
}

// MARK: - Setup UI
extension CustomTabBarController {
    private func setupControllers() {
        let networkService = NetworkService()

        let mainVC = UINavigationController(rootViewController: MainMenuController(networkService: networkService))
        mainVC.tabBarItem.title = "Главная"
        mainVC.tabBarItem.image = UIImage(named: "generalIcon")

        let petVC = UINavigationController(rootViewController: PetMenuController())
        petVC.tabBarItem.title = "Питомцы"
        petVC.tabBarItem.image = UIImage(named: "petIcon")

        let locationVC = LocationViewController()
        locationVC.tabBarItem.title = "Места"
        locationVC.tabBarItem.image = UIImage(named: "locationIcon")

        let profileVC = UINavigationController(rootViewController: ProfileViewController())
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
        if !UserDefaults.appPaidStatus() {
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) { [weak self] in
                self?.presentPremiumController(self)
            }
        }
    }
}
