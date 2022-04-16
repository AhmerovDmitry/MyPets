//
//  PremiumPresenter.swift
//  MyPets
//
//  Created by Dmitriy Akhmerov on 16.04.2022.
//  Copyright (c) 2022 Dmitriy Akhmerov. All rights reserved.
//

import UIKit

/// Протокол презентера экрана премиум подписки
protocol PremiumPresenterProtocol {

	/// Подготовка данных перед отображением
	/// - Parameter model: Модель данных
	func prepareData(from model: PremiumModel)
}

/// Презентер экрана премиум подписки
final class PremiumPresenter {

	/// Контроллер экрана премиум попдиски
	weak var viewController: PremiumViewControllerProtocol?
}

// MARK: - PremiumPresenterProtocol

extension PremiumPresenter: PremiumPresenterProtocol {

	func prepareData(from model: PremiumModel) {
		viewController?.updateScene(from: model)
	}
}
