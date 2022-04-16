//
//  PremiumTableCell.swift
//  MyPets
//
//  Created by Dmitriy Akhmerov on 15.01.2022.
//  Copyright (c) 2022 Dmitriy Akhmerov. All rights reserved.
//

import UIKit

/// Протокол ячейки экрана обучения
protocol PremiumTableCellProtocol {

	/// Конфигурация ячейки
	/// - Parameter text: Текст ячейки
	func configureCell(text: String?)

	/// Убрать нижнее подчеркивание ячейки
	func hideSeparatorView()
}

/// Ячейка экрана обучения
final class PremiumTableCell: UITableViewCell {

	/// Константные значения
	enum Constants {
		static let absoluteOffset: CGFloat = 16
	}

	// MARK: - UI Elements

	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
		label.textColor = .white.withAlphaComponent(0.8)
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false

		return label
	}()

	private let separatorView: UIView = {
		let view = UIView()
		view.backgroundColor = .white.withAlphaComponent(0.5)
		view.translatesAutoresizingMaskIntoConstraints = false

		return view
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Setup UI

	private func setupUI() {
		self.backgroundColor = .clear
		contentView.addSubview(descriptionLabel)
		contentView.addSubview(separatorView)

		NSLayoutConstraint.activate([
			descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.absoluteOffset),
			descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.absoluteOffset),
			descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

			separatorView.heightAnchor.constraint(equalToConstant: 1),
			separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		])
	}
}

// MARK: - PremiumTableCellProtocol

extension PremiumTableCell: PremiumTableCellProtocol {

	func configureCell(text: String?) {
		guard let text = text else { return }
		descriptionLabel.text = text
	}

	func hideSeparatorView() {
		separatorView.isHidden = true
	}
}
