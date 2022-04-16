//
//  PremiumInteractor.swift
//  MyPets
//
//  Created by Dmitriy Akhmerov on 16.04.2022.
//  Copyright (c) 2022 Dmitriy Akhmerov. All rights reserved.
//

import UIKit

/// Протокол интерактора экрана премиум подписки
protocol PremiumInteractorProtocol {

	/// Получить данные  из модели
	func fetchData()
}

/// Интерактор экрана премиум подписки
final class PremiumInteractor {

	/// Презентер экрана премиум подписки
	private let presenter: PremiumPresenterProtocol

	/// Инициализатор
	/// - Parameter presenter: Презентер экрана пермиум подписки
	init(presenter: PremiumPresenterProtocol) {
		self.presenter = presenter
	}
}

// MARK: - PremiumInteractorProtocol

extension PremiumInteractor: PremiumInteractorProtocol {

	func fetchData() {
		presenter.prepareData(from: PremiumModel())
	}
}
