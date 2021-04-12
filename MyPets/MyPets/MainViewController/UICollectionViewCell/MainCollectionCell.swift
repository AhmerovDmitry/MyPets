//
//  MainCollectionCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.04.2021.
//

import UIKit

class MainCollectionCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.text = "Расскажите нам о своём питомце"
        
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.text = "А мы будем давать советы по уходу и кормлению"
        
        return label
    }()
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "mainControllerImage")
        image.contentMode = .scaleAspectFill

        return image
    }()
    let bottomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(BottomMenuCell.self, forCellWithReuseIdentifier: "bottomCell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white

        return cv
    }()
    
    func setupConstraints() {
        [bottomCollectionView, imageView, titleLabel, descriptionLabel].forEach({ contentView.addSubview($0) })

        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 3 * 2),
            titleLabel.heightAnchor.constraint(equalToConstant: contentView.bounds.height / 2),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),

            descriptionLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 3 * 2),
            descriptionLabel.heightAnchor.constraint(equalToConstant: contentView.bounds.height / 2),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),

            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),

            bottomCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bottomCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            bottomCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bottomCollectionView.delegate = self
        bottomCollectionView.dataSource = self
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
