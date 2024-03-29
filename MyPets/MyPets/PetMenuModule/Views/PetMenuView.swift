//
//  PetMenuView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.08.2021.
//

import UIKit

final class PetMenuView: UIView {

    // MARK: - Property

    var presentControllerCallBack: (() -> Void)?

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
	private lazy var addPetButton = UIButton.createTypicalButton(title: "Добавить питомца",
																 backgroundColor: UIColor.CustomColor.purple,
																 borderWidth: nil,
																 target: self,
																 action: #selector(presentController))

    // MARK: - Init / Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    override func layoutSubviews() {
        super.layoutSubviews()
        setCornerRadiusForElements()
    }

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
            mainStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            mainStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
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
            addPetButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 64),
            addPetButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06),
            addPetButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            addPetButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    private func setCornerRadiusForElements() {
        addPetButton.layer.cornerRadius = addPetButton.bounds.height / 2
    }
}

// MARK: - Methods

extension PetMenuView {
    @objc private func presentController() {
        presentControllerCallBack?()
    }
}
