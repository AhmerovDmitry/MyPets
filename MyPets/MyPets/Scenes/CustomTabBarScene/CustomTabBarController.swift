//
//  CustomTabBarController.swift
//  MyPets
//
//  Created by Dmitriy Akhmerov on 15.10.2021.
//  Copyright (c) 2022 Dmitriy Akhmerov. All rights reserved.
//

import UIKit

/// Таб бар контроллера для выбора основных экранов
final class CustomTabBarController: UITabBarController {

	/// Координатор переходов
	private let coordinator: ScreenCoordinatorProtocol

	/// Сервис для работы с сохранением данных в CoreData
	private let storageService: StorageServiceProtocol

	/// Сервис для работы с сохранением/загрузкой легковесных данных
	private let userDefaultsService: UserDefaultsServiceProtocol

	/// Инициализатор
	/// - Parameters:
	///   - coordinator: Координатор переходов
	///   - storageService: Сервис для работы с сохранением данных в CoreData
	///   - userDefaultsService: Сервис для работы с сохранением/загрузкой легковесных данных
	init(coordinator: ScreenCoordinatorProtocol,
		 storageService: StorageServiceProtocol,
		 userDefaultsService: UserDefaultsServiceProtocol) {
		self.coordinator = coordinator
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
		presentPremium()
		setupTabBarSettings()
	}

	// MARK: - Setup Tab Bar

	private func setupTabBarSettings() {
		tabBar.layer.cornerRadius = UIView.basicCornerRadius
		tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		tabBar.backgroundColor = .white
		tabBar.backgroundImage = UIImage()
		tabBar.shadowImage = UIImage()
		tabBar.clipsToBounds = true
		tabBar.unselectedItemTintColor = UIColor.CustomColor.gray
		tabBar.tintColor = UIColor.CustomColor.purple
		view.bringSubviewToFront(tabBar)
		viewControllers = [
			setupController(MainMenuController(),
							title: "Главная",
							image: UIImage(named: "generalIcon")),
			setupController(PetMenuController(storageService: storageService, userDefaultsService: userDefaultsService),
							title: "Питомцы",
							image: UIImage(named: "petIcon")),
			setupController(MapController(),
							title: "Места",
							image: UIImage(named: "mapIcon")),
			setupController(ProfileController(storageService: storageService, userDefaultsService: userDefaultsService),
							title: "Профиль",
							image: UIImage(named: "profileIcon"))
		]
	}
}

// MARK: - Help Methods

private extension CustomTabBarController {

	/// Установка навигационного контроллера
	/// - Parameters:
	///   - controller: Контроллер
	///   - title: Заголовок таба контроллера
	///   - image: Изображение таба контроллера
	/// - Returns: Контроллер с настройками
	func setupController(_ controller: UIViewController, title: String, image: UIImage?) -> UIViewController {
		let controller = UINavigationController(rootViewController: controller)
		controller.tabBarItem.title = title
		controller.tabBarItem.image = image

		return controller
	}

	/// Метод показывающий преимум контроллер если покупка не совершена
	/// Возможно отключение показа контроллера нажатием на кнопку-заглушку "Купить Premium"
	func presentPremium() {
		if !userDefaultsService.value(forKey: .isAppPurchased) {
			DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
				guard let self = self else { return }
				self.coordinator.showPremiumScene(parent: self)
			}
		}
	}
}
