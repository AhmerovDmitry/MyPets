//
//  OnboardInteractor.swift
//  MyPets
//
//  Created by Dmitriy Akhmerov on 15.01.2022.
//  Copyright (c) 2022 Dmitriy Akhmerov. All rights reserved.
//

import UIKit

/// Протокол интерактора экрана обучения
protocol OnboardInteractorProtocol {

	/// Получить данные  из модели
	func fetchData()
}

/// Интерактор экрана обучения
final class OnboardInteractor {

	/// Презентер экрана обучения
	private let presenter: OnboardPresenterProtocol

	/// Инициализатор
	/// - Parameter presenter: Презентер экрана обучения
	init(presenter: OnboardPresenterProtocol) {
		self.presenter = presenter
	}
}

// MARK: - OnboardInteractorProtocol

extension OnboardInteractor: OnboardInteractorProtocol {

	func fetchData() {
		let model = OnboardModel()
		presenter.prepareData(from: model)
	}
}
