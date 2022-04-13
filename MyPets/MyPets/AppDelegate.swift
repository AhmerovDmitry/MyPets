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

		/// Сервис для работы с сохранением/загрузкой легковесных данных
		let userDefaultsService = UserDefaultsService(repository: UserDefaults.standard)

		/// Координатор переходов
		let coordinator = ScreenCoordinator(userDefaultsService: userDefaultsService)

		window = UIWindow(frame: UIScreen.main.bounds)
		window?.overrideUserInterfaceStyle = .light
		window?.makeKeyAndVisible()

		window?.rootViewController = coordinator.startFlow()

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
