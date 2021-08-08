//
//  CustomTabBarController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.10.2020.
//

import UIKit

final class CustomTabBarController: UITabBarController {
    public var controllers: [UIViewController]?
    
    private let mainVC = UINavigationController(rootViewController: MainViewController())
    private let petVC = UINavigationController(rootViewController: MainPetViewController())
    private let locationVC = LocationViewController()
    private let profileVC = UINavigationController(rootViewController: ProfileViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarUI()
        setBarItems()
        
        controllers = [mainVC, petVC, locationVC, profileVC]
        presentPremium()
    }
}

// MARK: - Setup UI
extension CustomTabBarController {
    private func setTabBarUI() {
        tabBar.backgroundColor = .white
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.unselectedItemTintColor = UIColor.CustomColor.gray
        tabBar.tintColor = UIColor.CustomColor.purple
    }
    private func setBarItems() {
        mainVC.tabBarItem.title = "Главная"
        mainVC.tabBarItem.image = UIImage(named: "generalIcon")
        
        petVC.tabBarItem.title = "Питомцы"
        petVC.tabBarItem.image = UIImage(named: "petIcon")
        
        locationVC.tabBarItem.title = "Места"
        locationVC.tabBarItem.image = UIImage(named: "locationIcon")
        
        profileVC.tabBarItem.title = "Профиль"
        profileVC.tabBarItem.image = UIImage(named: "profileIcon")
    }
    private func presentPremium() {
        if !UserDefaults.appPaidStatus() {
            DispatchQueue.global().async { [weak self] in
                sleep(1)
                DispatchQueue.main.async {
                    self?.presentPremiumController(parent: self)
                }
            }
        }
//        if !UserDefaults.appPaidStatus() {
//            sleep(1)
//            presentPremiumController(parent: self)
//        }
    }
}
