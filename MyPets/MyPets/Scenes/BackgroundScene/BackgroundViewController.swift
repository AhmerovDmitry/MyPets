//
//  BackgroundViewController.swift
//  MyPets
//
//  Created by Dmitriy Akhmerov on 17.01.2022.
//  Copyright (c) 2022 Dmitriy Akhmerov. All rights reserved.
//

import UIKit

/// Контроллер-заглушка, нужен для старта флоу приложения
final class BackgroundViewController: UIViewController {

	/// Сервис для работы с сохранением/загрузкой легковесных данных
	private let userDefaultsService: UserDefaultsServiceProtocol

	/// Сервис для работы с сохранением данных в CoreData
	private let storageService: StorageServiceProtocol

	/// Координатор переходов
	private let coordinator: ScreenCoordinatorProtocol

	init(userDefaultsService: UserDefaultsServiceProtocol,
		 storageService: StorageServiceProtocol,
		 coordinator: ScreenCoordinatorProtocol) {
		self.userDefaultsService = userDefaultsService
		self.storageService = storageService
		self.coordinator = coordinator
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		userDefaultsService.value(forKey: .isNotFirstLaunch) ?
			coordinator.present(controller: .mainTabBarScene, on: self) :
			coordinator.present(controller: .onboardScene, on: self)
	}
}
