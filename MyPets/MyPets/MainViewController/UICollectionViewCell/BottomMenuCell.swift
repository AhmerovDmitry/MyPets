//
//  BottomMenuCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.04.2021.
//

import UIKit

class BottomMenuCell: UICollectionViewCell {
    let models = [
        ["title": "MyPets Premium",
         "description": "Подарите своему питомцу максимум любви и заботы",
         "image": "bottomMenuImage_1"],
        ["title": "Закончился корм?",
         "description": "Найдите ближайший зоомагазин на карте за несколько минут.",
         "image": "bottomMenuImage_2"],
        ["title": "Куда сходить?",
         "description": "Все места, где будут рады вам и вашему питомцу — на нашей карте.",
         "image": "bottomMenuImage_3"],
    ]
    let cellColor = [UIColor.CustomColor.purple,
                     UIColor.CustomColor.lightPurple,
                     UIColor.CustomColor.lightGray2]
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    func setupConstraints() {
        [imageView, titleLabel, descriptionLabel].forEach({ contentView.addSubview($0) })
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 3 * 2),
            titleLabel.heightAnchor.constraint(equalToConstant: contentView.bounds.height / 3),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                        
            descriptionLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 3 * 2),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
