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

	/// Модель данных для экрана обучения
	private var model: OnboardModel?

	/// Инициализатор
	/// - Parameters:
	///  - userDefaultsService: Сервис работы с сохранением легковесных данных
	///  - interactor: Интерактор экрана обучения
	init(userDefaultsService: UserDefaultsServiceProtocol,
		 interactor: OnboardInteractorProtocol,
		 onboardView: OnboardViewProtocol = OnboardView(frame: UIScreen.main.bounds)) {
		self.userDefaultsService = userDefaultsService
		self.interactor = interactor
		self.onboardView = onboardView
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
		onboardView.setPageControl(count: model.imageNameList.count)
	}
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension OnboardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let cellCount = model?.imageNameList.count else { return 0 }
		return cellCount
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: onboardView.cellID,
			for: indexPath) as? OnboardCollectionCell else { return UICollectionViewCell() }

		cell.configureCell(image: model?.imageNameList[indexPath.row],
						   description: model?.descriptionList[indexPath.row])

		return cell
	}
}
