//
//  ScreenCoordinator.swift
//  MyPets
//
//  Created by Dmitriy Akhmerov on 15.01.2022.
//  Copyright (c) 2022 Dmitriy Akhmerov. All rights reserved.
//

import UIKit

/// Протокол координатора
protocol ScreenCoordinatorProtocol {

	/// Функция запуска, с помощью которой определяется какой экран нужно запустить первым
	/// - Returns: Стартовый контроллер
	func startFlow() -> UIViewController

	/// Показать экран с обучением
	func showOnboardScene(parent: UIViewController)

	/// Показать основной экран с нижним навигационным элементом
	func showMainTabBarScene(parent: UIViewController)

	/// Показать экран с возможностью купить премиум версию
	func showPremiumScene(parent: UIViewController)
}

/// Координатор переходов
final class ScreenCoordinator: ScreenCoordinatorProtocol {

	/// Сервис для работы с сохранением/загрузкой легковесных данных
	private let userDefaultsService: UserDefaultsServiceProtocol

	/// Сервис для работы с сохранением данных в CoreData
	private let storageService: StorageServiceProtocol

	/// Инициализатор
	/// - Parameters:
	///  - userDefaultsService: Сервис для работы с сохранением/загрузкой легковесных данных
	///  - storaService: Сервис для работы с сохранением данных в CoreData
	init(userDefaultsService: UserDefaultsServiceProtocol,
		 storageService: StorageServiceProtocol) {
		self.userDefaultsService = userDefaultsService
		self.storageService = storageService
	}

	func startFlow() -> UIViewController {
		let controller = BackgroundViewController(userDefaultsService: userDefaultsService,
												  storageService: storageService,
												  coordinator: self)

		return controller
	}

	func showOnboardScene(parent: UIViewController) {
		let presenter = OnboardPresenter()
		let interactor = OnboardInteractor(presenter: presenter)
		let viewController = OnboardViewController(userDefaultsService: userDefaultsService,
												   interactor: interactor,
												   coordinator: self)
		presenter.viewController = viewController

		present(controller: viewController, parent: parent)
	}

	func showMainTabBarScene(parent: UIViewController) {
		let viewController = CustomTabBarController(storageService: storageService,
													userDefaultsService: userDefaultsService)

		present(controller: viewController, parent: parent)
	}

	func showPremiumScene(parent: UIViewController) {
		let presenter = PremiumPresenter()
		let interactor = PremiumInteractor(presenter: presenter)
		let viewController = PremiumViewController(userDefaultsService: userDefaultsService, interactor: interactor)
		presenter.viewController = viewController

		present(controller: viewController, parent: parent)
	}
}

private extension ScreenCoordinator {

	/// Модально показать экран в полном окне
	/// - Parameter controller: Контроллер для показа
	func present(controller: UIViewController, parent: UIViewController) {

		controller.modalPresentationStyle = .fullScreen
		parent.present(controller, animated: true)
	}
}
