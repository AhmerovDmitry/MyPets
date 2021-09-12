//
//  AppDelegate.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 09.10.2020.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // MARK: - Services
        let userDefaultsService = UserDefaultsService()

        /// Если приложение запускается впервые
        let onboardVC = OnboardController(userDefaultsService: userDefaultsService)
        /// Если приложение ранее запускалось (запуск без OnboardVC)
        let tabBarC = CustomTabBarController(userDefaultsService: userDefaultsService)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()

        /// Проверка ключа из UserDefaults на то, запускается приложение первый раз или нет
        if userDefaultsService.value(forKey: .isNotFirstLaunch) {
            window?.rootViewController = tabBarC
        } else {
            window?.rootViewController = onboardVC
        }

        return true
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PetInformation")
        container.loadPersistentStores(completionHandler: { _, error  in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
