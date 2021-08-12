//
//  PetMenuView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.08.2021.
//

import UIKit

final class PetMenuView: UIView {
    // MARK: - Initialization & Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        addPetButton.layer.cornerRadius = addPetButton.bounds.height / 2
    }
    
    // MARK: - Properties
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.setCustomSpacing(8, after: titleText)
        return stackView
    }()
    private let petImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "IconPet")
        image.contentMode = .scaleAspectFit
        return image
    }()
    private let titleText: UILabel = {
        let label = UILabel()
        label.text = "Добавьте питомца"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor.CustomColor.dark
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let descriptionText: UILabel = {
        let label = UILabel()
        label.text = "Все данные вашего питомца будут всегда под рукой"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.CustomColor.dark
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    private let addPetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить питомца", for: .normal)
        button.backgroundColor = UIColor.CustomColor.purple
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(presentController), for: .touchUpInside)
        return button
    }()
}

// MARK: - Setup UI
extension PetMenuView {
    private func setupUI() {
        self.backgroundColor = .white
        setMainStackViewConstraints()
        addOtherElementsInStackMainViewConstraints()
        setAddPetButtonConstraints()
    }
    private func setMainStackViewConstraints() {
        self.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.bottomAnchor.constraint(equalTo: self.centerYAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainStackView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    private func addOtherElementsInStackMainViewConstraints() {
        [petImage, titleText, descriptionText].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            mainStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleText.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            descriptionText.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8)
        ])
    }
    private func setAddPetButtonConstraints() {
        self.addSubview(addPetButton)
        addPetButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addPetButton.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 64),
            addPetButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06),
            addPetButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            addPetButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

// MARK: - Actions
extension PetMenuView {
    @objc func presentController() {}
}
