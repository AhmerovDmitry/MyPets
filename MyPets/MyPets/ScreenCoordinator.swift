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
	/// - Returns: Контроллер для запуска
	func showOnboardScene() -> UIViewController
}

/// Координатор переходов
final class ScreenCoordinator: ScreenCoordinatorProtocol {

	private let userDefaultsService: UserDefaultsServiceProtocol

	/// Инициализатор
	/// - Parameter userDefaultsService: Сервис для работы с сохранением/загрузкой легковесных данных
	init(userDefaultsService: UserDefaultsServiceProtocol) {
		self.userDefaultsService = userDefaultsService
	}

	func startFlow() -> UIViewController {
		if userDefaultsService.value(forKey: .isNotFirstLaunch) {
			return showOnboardScene()
		} else {
			return showOnboardScene()
		}
	}

	func showOnboardScene() -> UIViewController {
		let presenter = OnboardPresenter()
		let interactor = OnboardInteractor(presenter: presenter)
		let viewController = OnboardViewController(userDefaultsService: userDefaultsService, interactor: interactor)
		presenter.viewController = viewController

		return viewController
	}
}
