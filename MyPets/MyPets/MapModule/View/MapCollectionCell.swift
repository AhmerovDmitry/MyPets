//
//  MapCollectionCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 14.10.2021.
//

import UIKit

final class MapCollectionCell: UICollectionViewCell {

    // MARK: - Property

    private let requestButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.CustomColor.dark, for: .normal)
        button.backgroundColor = UIColor.CustomColor.lightGray2
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
        setViewsCornerRadius()
    }

    private func setupUI() {
        setRequestLabelConstraints()
    }
    private func setRequestLabelConstraints() {
        self.addSubview(requestButton)
        requestButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            requestButton.topAnchor.constraint(equalTo: self.topAnchor),
            requestButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            requestButton.leftAnchor.constraint(equalTo: self.leftAnchor),
            requestButton.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    private func setViewsCornerRadius() {
        requestButton.layer.cornerRadius = requestButton.bounds.height / 2
    }
}

// MARK: - Public Methods

extension MapCollectionCell {
    func configureCell(requestTitle title: String) {
        requestButton.setTitle(title, for: .normal)
    }
}
