//
//  TabBarAddPetButton.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 07.10.2021.
//

import UIKit

final class TabBarAddPetButton: UIView {

    // MARK: - Property

    private let addPetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "addButton"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.CustomColor.purple
        return button
    }()

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
        setAddPetButtonConstraints()
    }
    private func setAddPetButtonConstraints() {
        self.addSubview(addPetButton)
        addPetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addPetButton.widthAnchor.constraint(equalTo: self.widthAnchor),
            addPetButton.heightAnchor.constraint(equalTo: self.heightAnchor),
            addPetButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addPetButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    private func setCornerRadiusForElements() {
        addPetButton.imageEdgeInsets = UIEdgeInsets(top: addPetButton.bounds.height / 3,
                                                    left: addPetButton.bounds.height / 3,
                                                    bottom: addPetButton.bounds.height / 3,
                                                    right: addPetButton.bounds.height / 3)
        addPetButton.layer.cornerRadius = addPetButton.bounds.height / 2
    }
}
