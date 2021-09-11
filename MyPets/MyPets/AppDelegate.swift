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
        let onboardVC = OnboardController()     // Если приложение запускается впервые
        let tabBarC = CustomTabBarController()  // Если приложение ранее запускалось (запуск без OnboardVC)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
        if !UserDefaults.isFirstLaunch() {
            window?.rootViewController = onboardVC
        } else {
            window?.rootViewController = tabBarC
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
