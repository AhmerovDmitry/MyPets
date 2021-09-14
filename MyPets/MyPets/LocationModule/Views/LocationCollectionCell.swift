//
//  LocationCollectionCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 23.10.2020.
//

import UIKit

final class LocationCollectionCell: UICollectionViewCell {
    private let titlePlacemarkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.backgroundColor = .lightGray
        label.isUserInteractionEnabled = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LocationCollectionCell {
    private func setupUI() {
        self.backgroundColor = .white
        setTitlePlacemarkLabelConstraints()
    }
    private func setTitlePlacemarkLabelConstraints() {
        self.addSubview(titlePlacemarkLabel)
        titlePlacemarkLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titlePlacemarkLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titlePlacemarkLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            titlePlacemarkLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            titlePlacemarkLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}

extension LocationCollectionCell {
    func configureCell(_ title: String) {
        titlePlacemarkLabel.text = title
    }
}
