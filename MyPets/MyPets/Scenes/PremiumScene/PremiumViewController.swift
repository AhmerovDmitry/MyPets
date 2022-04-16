//
//  PremiumViewController.swift
//  MyPets
//
//  Created by Dmitriy Akhmerov on 08.08.2021.
//  Copyright (c) 2022 Dmitriy Akhmerov. All rights reserved.
//

import UIKit

/// Протокол экрана премиум подписки
protocol PremiumViewControllerProtocol: AnyObject {

	/// Показать обучение
	func displayPremium()

	/// Обновление сцены
	/// - Parameter model: Модель данных
	func updateScene(from model: PremiumModel)

	/// Спрятать экран
	/// - Parameter withPurchase: Флаг показывающий оформил клиент премиум подписку или нет
	func dismissController(withPurchase: Bool)
}

/// Контроллер экрана премиум подписки
final class PremiumViewController: UIViewController {

	/// Сервис для работы с сохранением/загрузкой легковесных данных
	private let userDefaultsService: UserDefaultsServiceProtocol

	/// Вью экрана премиум подписки
	private let premiumView: PremiumViewProtocol

	/// Интерактор экрана премиум подписки
	private let interactor: PremiumInteractorProtocol

	/// Модель данных для экрана премиум подписки
	private var model: PremiumModel?

	/// Инициализатор
	/// - Parameters:
	///  - userDefaultsService: Сервис работы с сохранением легковесных данных
	///  - interactor: Интерактор экрана премиум подписки
	///  - onboardView: Вью экрана премиум подписки
	init(userDefaultsService: UserDefaultsServiceProtocol,
		 interactor: PremiumInteractorProtocol,
		 premiumView: PremiumViewProtocol = PremiumView(frame: UIScreen.main.bounds)) {
		self.userDefaultsService = userDefaultsService
		self.interactor = interactor
		self.premiumView = premiumView
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = premiumView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		premiumView.setViewParent(controller: self)
		premiumView.setTableViewDelegate(self)
		premiumView.setTableViewDataSource(self)
		displayPremium()
	}
}

// MARK: - PremiumViewControllerProtocol

extension PremiumViewController: PremiumViewControllerProtocol {

	func displayPremium() {
		interactor.fetchData()
	}

	func updateScene(from model: PremiumModel) {
		self.model = model
	}

	func dismissController(withPurchase: Bool) {
		dismiss(animated: true, completion: nil)
		if withPurchase {
			userDefaultsService.setValue(true, forKey: .isAppPurchased)
			return
		}
	}
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension PremiumViewController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return model?.descriptionList.count ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: premiumView.cellID,
			for: indexPath) as? PremiumTableCell,
			  let count = model?.descriptionList.count else { return UITableViewCell() }
		cell.configureCell(text: model?.descriptionList[indexPath.row])

		if indexPath.row == count - 1 {
			cell.hideSeparatorView()
		}

		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		UITableView.automaticDimension
	}
}
