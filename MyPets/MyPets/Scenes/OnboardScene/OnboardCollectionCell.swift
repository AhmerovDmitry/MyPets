//
//  OnboardCollectionCell.swift
//  MyPets
//
//  Created by Dmitriy Akhmerov on 15.01.2022.
//  Copyright (c) 2022 Dmitriy Akhmerov. All rights reserved.
//

import UIKit

/// Протокол ячейки экрана обучения
protocol OnboardCollectionCellProtocol {

	/// Конфигурация ячейки
	/// - Parameters:
	///  - image: Изображение
	///  - description: Описание
	func configureCell(image: String, description: String)
}

/// Ячейка экрана обучения
final class OnboardCollectionCell: UICollectionViewCell {

	// MARK: - UI Elements

	private let onboardView: UIImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFit

		return image
	}()

	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
		label.textColor = UIColor.CustomColor.dark
		label.numberOfLines = 2
		label.adjustsFontSizeToFitWidth = true

		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Setup UI

	private func setupUI() {
		setDescriptionLabelConstraints()
		setOnboardViewConstraints()
	}

	private func setDescriptionLabelConstraints() {
		self.addSubview(descriptionLabel)
		descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			descriptionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
			descriptionLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06),
			descriptionLabel.topAnchor.constraint(equalTo: self.centerYAnchor),
			descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		])
	}

	private func setOnboardViewConstraints() {
		self.addSubview(onboardView)
		onboardView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			onboardView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
			onboardView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
			onboardView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			onboardView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor)
		])
	}
}

extension OnboardCollectionCell {

	func configureCell(image: String?, description: String?) {
		guard let image = image, let description = description else { return }
		onboardView.image = UIImage(named: image)
		descriptionLabel.text = description
	}
}
