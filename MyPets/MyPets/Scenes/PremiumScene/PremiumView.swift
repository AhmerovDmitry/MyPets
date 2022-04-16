//
//  PremiumView.swift
//  MyPets
//
//  Created by Dmitriy Akhmerov on 08.08.2021.
//  Copyright (c) 2022 Dmitriy Akhmerov. All rights reserved.
//

import UIKit

/// Протокол вью обучения
protocol PremiumViewProtocol: UIView {

	/// Установить делегата таблицы
	/// - Parameter controller: Контроллер, который будет являться делегатом таблицы
	func setTableViewDelegate<T: UITableViewDelegate>(_ controller: T)

	/// Установить источника данных таблицы
	/// - Parameter controller: Контроллер, который будет являться источником данных таблицы
	func setTableViewDataSource<T: UITableViewDataSource>(_ controller: T)

	/// Установить родительский контроллер для вью
	func setViewParent(controller: PremiumViewControllerProtocol)

	/// Идентификатор ячейки
	var cellID: String { get }
}

/// Вью экрана премиум подписки
final class PremiumView: UIView {

	weak var controller: PremiumViewControllerProtocol?

	// MARK: - UI Elements

	private lazy var mainStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.alignment = .center
		stackView.axis = .vertical
		stackView.spacing = 32
		stackView.setCustomSpacing(24, after: titleStackView)
		stackView.setCustomSpacing(4, after: priceLabel)
		stackView.translatesAutoresizingMaskIntoConstraints = false

		return stackView
	}()

	private let titleStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.alignment = .center
		stackView.axis = .horizontal
		stackView.spacing = 10
		stackView.translatesAutoresizingMaskIntoConstraints = false

		return stackView
	}()

	private let closeButton: UIButton = {
		let button = UIButton(type: .system)
		button.alpha = 0.7
		button.setImage(UIImage(named: "closeButton"), for: .normal)
		button.tintColor = .white
		button.contentHorizontalAlignment = .fill
		button.contentVerticalAlignment = .fill
		button.translatesAutoresizingMaskIntoConstraints = false

		return button
	}()

	private let titleLogo: UIImageView = {
		let image = UIImageView()
		image.image = UIImage(named: "crownIcon")
		image.contentMode = .scaleAspectFit
		image.translatesAutoresizingMaskIntoConstraints = false

		return image
	}()

	private let titleText: UILabel = {
		let label = UILabel()
		label.text = "MyPets Premium"
		label.textColor = .white
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
		label.adjustsFontSizeToFitWidth = true
		label.translatesAutoresizingMaskIntoConstraints = false

		return label
	}()

	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.isScrollEnabled = false
		tableView.register(PremiumTableCell.self, forCellReuseIdentifier: cellID)
		tableView.backgroundColor = .clear
		tableView.separatorStyle = .none
		tableView.translatesAutoresizingMaskIntoConstraints = false

		return tableView
	}()

	private let priceLabel: UILabel = {
		let label = UILabel()
		label.text = "149 ₽"
		label.textColor = .white
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 48, weight: .semibold)
		label.adjustsFontSizeToFitWidth = true
		label.translatesAutoresizingMaskIntoConstraints = false

		return label
	}()

	private let priceDescriptionLabel: UILabel = {
		let label = UILabel()
		label.text = "Навсегда и без ограничений"
		label.textColor = .white
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		label.adjustsFontSizeToFitWidth = true

		return label
	}()

	private let buyButton = UIButton.createTypicalButton(title: "Получить Premium",
														 backgroundColor: .white,
														 borderWidth: nil,
														 target: self,
														 action: #selector(closeControllerWithPurchase))

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
		setupBackgroundGradient()
		setButtonAction()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		setCornerRadiusForElements()
	}
}

// MARK: - Setup UI

private extension PremiumView {

	func setupUI() {
		[closeButton, mainStackView, buyButton].forEach { addSubview($0) }
		[titleLogo, titleText].forEach { titleStackView.addArrangedSubview($0) }
		[titleStackView, tableView, priceLabel, priceDescriptionLabel].forEach { mainStackView.addArrangedSubview($0) }

		NSLayoutConstraint.activate([
			closeButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.04),
			closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
			closeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -UIScreen.main.bounds.width / 25),
			closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: UIScreen.main.bounds.width / 25),

			mainStackView.widthAnchor.constraint(equalToConstant: bounds.width / 1.2),
			mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -32),
			mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor),

			tableView.leftAnchor.constraint(equalTo: mainStackView.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: mainStackView.rightAnchor),
			tableView.heightAnchor.constraint(equalToConstant: bounds.height / 3),

			buyButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 32),
			buyButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.06),
			buyButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
			buyButton.centerXAnchor.constraint(equalTo: centerXAnchor)
		])
	}

	func setCornerRadiusForElements() {
		buyButton.layer.cornerRadius = buyButton.bounds.height / 2
	}

	func setupBackgroundGradient() {
		setGradientEffect(self,
						  colorOne: UIColor.PurpleGradientColor.darkPurple,
						  colorTwo: UIColor.PurpleGradientColor.lightPurple,
						  startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
	}
}

// MARK: - User Interaction

private extension PremiumView {

	private func setButtonAction() {
		closeButton.addTarget(self, action: #selector(closeControllerWithoutPurchase), for: .touchUpInside)
	}

	@objc func closeControllerWithoutPurchase() {
		controller?.dismissController(withPurchase: false)
	}

	@objc func closeControllerWithPurchase() {
		controller?.dismissController(withPurchase: true)
	}
}

// MARK: - PremiumViewProtocol

extension PremiumView: PremiumViewProtocol {

	var cellID: String {
		"PremiumCellId"
	}

	func setTableViewDelegate<T: UITableViewDelegate>(_ controller: T) {
		tableView.delegate = controller
	}

	func setTableViewDataSource<T: UITableViewDataSource>(_ controller: T) {
		tableView.dataSource = controller
	}

	func setViewParent(controller: PremiumViewControllerProtocol) {
		self.controller = controller
	}
}
