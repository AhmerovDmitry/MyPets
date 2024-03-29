//
//  PetCollectionCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.08.2021.
//

import UIKit

final class PetCollectionCell: UICollectionViewCell {

    // MARK: - Property

    private let petPhoto: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.backgroundColor = UIColor.CustomColor.lightGray
        image.layer.cornerRadius = UIView.basicCornerRadius
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return image
    }()
    private let petName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.CustomColor.dark
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    private let petBreed: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.CustomColor.dark
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    private let petAge: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.CustomColor.gray
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
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

    // MARK: - UI

    override func prepareForReuse() {
        super.prepareForReuse()
        petPhoto.image = nil
    }
    private func setupUI() {
        self.backgroundColor = .white
        self.setDefaultShadow()
        setPetPhotoConstraints()
        setPetNameConstraints()
        setPetBreedConstraints()
        setPetAgeConstraints()
    }
    private func setPetPhotoConstraints() {
        self.addSubview(petPhoto)
        petPhoto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            petPhoto.widthAnchor.constraint(equalTo: self.widthAnchor),
            petPhoto.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.66),
            petPhoto.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            petPhoto.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
    private func setPetNameConstraints() {
        self.addSubview(petName)
        petName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            petName.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            petName.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.165),
            petName.topAnchor.constraint(equalTo: petPhoto.bottomAnchor),
            petName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10)
        ])
    }
    private func setPetBreedConstraints() {
        self.addSubview(petBreed)
        petBreed.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            petBreed.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            petBreed.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.165),
            petBreed.topAnchor.constraint(equalTo: petName.bottomAnchor),
            petBreed.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10)
        ])
    }
    private func setPetAgeConstraints() {
        self.addSubview(petAge)
        petAge.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            petAge.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            petAge.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.165),
            petAge.topAnchor.constraint(equalTo: petPhoto.bottomAnchor),
            petAge.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
        ])
    }
}

// MARK: - Public Methods

extension PetCollectionCell {
    func configureCell(photo: UIImage?, name: String, breed: String, age: String) {
        petPhoto.contentMode = .scaleAspectFit
        petPhoto.image = UIImage(named: "unknownImage")
        if let photo = photo {
            petPhoto.contentMode = .scaleAspectFill
            petPhoto.image = photo
        }
        petName.text = name
        petBreed.text = breed
        petAge.text = age
    }
}
