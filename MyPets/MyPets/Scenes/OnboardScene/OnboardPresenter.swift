//
//  OnboardPresenter.swift
//  MyPets
//
//  Created by Dmitriy Akhmerov on 15.01.2022.
//  Copyright (c) 2022 Dmitriy Akhmerov. All rights reserved.
//

import UIKit

/// Протокол презентера экрана обучения
protocol OnboardPresenterProtocol {

	/// Подготовка данных перед отображением
	/// - Parameter model: Модель данных
	func prepareData(from model: OnboardModel)
}

/// Презентер экрана обучения
final class OnboardPresenter {

	/// Контроллер экрана обучения
	weak var viewController: OnboardViewControllerProtocol?
}

// MARK: - OnboardPresenterProtocol

extension OnboardPresenter: OnboardPresenterProtocol {

	func prepareData(from model: OnboardModel) {
		viewController?.updateScene(from: model)
	}
}
