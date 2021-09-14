//
//  LocationCollectionCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 23.10.2020.
//

import UIKit

final class LocationCollectionCell: UICollectionViewCell {
    // MARK: - Initialization & Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Properties
    private let requestButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitleColor(UIColor.CustomColor.purple, for: .highlighted)
        button.setTitleColor(UIColor.CustomColor.dark, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return button
    }()
}

// MARK: - Setup UI
extension LocationCollectionCell {
    private func setupUI() {
        self.backgroundColor = .white
        setRequestButtonConstraints()
    }
    private func setRequestButtonConstraints() {
        self.addSubview(requestButton)
        requestButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            requestButton.topAnchor.constraint(equalTo: self.topAnchor),
            requestButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            requestButton.leftAnchor.constraint(equalTo: self.leftAnchor),
            requestButton.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}

// MARK: - Public Methods
extension LocationCollectionCell {
    func configureCell(_ title: String) {
        requestButton.setTitle(title, for: .normal)
    }
    func requestButtonAction(_ target: UIViewController, action: Selector) {
        requestButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
