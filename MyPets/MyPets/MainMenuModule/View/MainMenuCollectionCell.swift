//
//  MainMenuCollectionCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.08.2021.
//

import UIKit

final class MainMenuCollectionCell: UICollectionViewCell {

    // MARK: - Initialization & Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties
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
}

// MARK: - Setup UI
extension MainMenuCollectionCell {
    private func setupUI() {
        self.setDefaultShadow()
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

// MARK: - Public Methods
extension MainMenuCollectionCell {
    func configureCell(image: String, description: String) {
        onboardView.image = UIImage(named: image)
        descriptionLabel.text = description
    }
}
