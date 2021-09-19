//
//  PetInfoCollectionCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.08.2021.
//

import UIKit

final class PetInfoCollectionCell: UICollectionViewCell {

    // MARK: - Property

    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Меню находится в разработке"
        label.font = UIFont.systemFont(ofSize: 16, weight: .ultraLight)
        label.tintColor = UIColor.CustomColor.dark
        return label
    }()

    // MARK: - Init / Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI

    private func setupUI() {
        self.backgroundColor = .white
        self.setDefaultShadow()

        self.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label.leftAnchor.constraint(equalTo: self.leftAnchor),
            label.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}
