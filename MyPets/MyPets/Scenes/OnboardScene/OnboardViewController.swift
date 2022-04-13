//
//  OnboardViewController.swift
//  MyPets
//
//  Created by Dmitriy Akhmerov on 15.01.2022.
//  Copyright (c) 2022 Dmitriy Akhmerov. All rights reserved.
//

import UIKit

/// Поротокол обучающего экрана
protocol OnboardViewControllerProtocol: AnyObject {

	/// Показать обучение
	func displayOnboard()

	/// Обновление сцены
	/// - Parameter model: Модель данных
	func updateScene(from model: OnboardModel)
}

/// Контроллер обучающего экрана
class OnboardViewController: UIViewController {

	/// Сервис для работы с сохранением/загрузкой легковесных данных
	private let userDefaultsService: UserDefaultsServiceProtocol

	/// Вью экрана обучения
	private let onboardView: OnboardViewProtocol

	/// Интерактор экрана обучения
	private let interactor: OnboardInteractorProtocol

	private var model: OnboardModel?

	/// Инициализатор
	/// - Parameter userDefaultsService: Сервис работы с сохранением легковесных данных
	init(userDefaultsService: UserDefaultsServiceProtocol,
		 interactor: OnboardInteractorProtocol) {
		self.userDefaultsService = userDefaultsService
		self.interactor = interactor
		self.onboardView = OnboardView(frame: UIScreen.main.bounds)
		super.init(nibName: nil, bundle: nil)
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = onboardView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		onboardView.setCollectionViewDelegate(self)
		onboardView.setCollectionViewDataSource(self)
		displayOnboard()
	}

	private func presentTabBarController() {
		userDefaultsService.setValue(true, forKey: .isNotFirstLaunch)
	}
}

// MARK: - OnboardViewControllerProtocol

extension OnboardViewController: OnboardViewControllerProtocol {

	func displayOnboard() {
		interactor.fetchData()
	}

	func updateScene(from model: OnboardModel) {
		self.model = model
		onboardView.setPageControl(count: model.imagesName.count)
	}
}

extension OnboardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let cellCount = model?.imagesName.count else { return 0 }
		return cellCount
	}

	func collectionView(_ collectionView: UICollectionView,
						cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: onboardView.cellID,
			for: indexPath
		) as? OnboardCollectionCell else { return UICollectionViewCell() }

		cell.configureCell(image: model?.imagesName[indexPath.row] ?? "",
						   description: model?.description[indexPath.row] ?? "")

		return cell
	}
}
