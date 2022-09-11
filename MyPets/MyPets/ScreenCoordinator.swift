//
//  ScreenCoordinator.swift
//  MyPets
//
//  Created by Dmitriy Akhmerov on 15.01.2022.
//  Copyright (c) 2022 Dmitriy Akhmerov. All rights reserved.
//

import UIKit

/// Список сцен приложения
enum AppScenes {
	/// Сцена обучения
	case onboardScene
	/// Сцена покупки премиум подписки
	case premiumScene
	/// Сцена главного экрана
	case mainTabBarScene
}

/// Протокол координатора
protocol ScreenCoordinatorProtocol {

	/// Функция запуска, с помощью которой определяется какой экран нужно запустить первым
	/// - Returns: Стартовый контроллер
	func startFlow() -> UIViewController

	/// Функция показа контроллеров
	/// - Parameters:
	///   - controller: Контроллера для показа
	///   - parent: Родительский контроллер
	func present(controller: AppScenes, on parent: UIViewController)
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

	func present(controller: AppScenes, on parent: UIViewController) {
		switch controller {
		case .onboardScene:
			showOnboardScene(on: parent)
		case .premiumScene:
			showPremiumScene(on: parent)
		case .mainTabBarScene:
			showMainTabBarScene(on: parent)
		}
	}
}

// MARK: - Controller Builders

private extension ScreenCoordinator {

	func showOnboardScene(on parent: UIViewController) {
		let presenter = OnboardPresenter()
		let interactor = OnboardInteractor(presenter: presenter)
		let viewController = OnboardViewController(userDefaultsService: userDefaultsService,
												   interactor: interactor,
												   coordinator: self)
		presenter.viewController = viewController

		present(controller: viewController, parent: parent)
	}

	func showMainTabBarScene(on parent: UIViewController) {
		let viewController = CustomTabBarController(coordinator: self,
													storageService: storageService,
													userDefaultsService: userDefaultsService)

		present(controller: viewController, parent: parent)
	}

	func showPremiumScene(on parent: UIViewController) {
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
