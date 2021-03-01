//
//  EntityCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 21.02.2021.
//

import UIKit

class EntityCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.CustomColor.lightGray
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        
        return view
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = UIColor.CustomColor.dark
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    let breedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = UIColor.CustomColor.dark
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
        return label
    }()
    let ageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = UIColor.CustomColor.gray
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        [imageView, nameLabel, breedLabel, ageLabel].forEach({ self.addSubview($0) })
        
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: (self.bounds.height / 3) * 2).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        nameLabel.widthAnchor.constraint(equalToConstant: self.bounds.width / 2).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: (self.bounds.height / 3) / 2).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        breedLabel.widthAnchor.constraint(equalToConstant: self.bounds.width / 2).isActive = true
        breedLabel.heightAnchor.constraint(equalToConstant: (self.bounds.height / 3) / 2).isActive = true
        breedLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        breedLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        ageLabel.widthAnchor.constraint(equalToConstant: self.bounds.width / 2).isActive = true
        ageLabel.heightAnchor.constraint(equalToConstant: (self.bounds.height / 3) / 2).isActive = true
        ageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        ageLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
    }
}
