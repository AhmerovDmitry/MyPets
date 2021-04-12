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

extension MainCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.bounds.width / 1.35, height: UIScreen.main.bounds.height / 6.1)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomCell", for: indexPath) as! BottomMenuCell
        let image = cell.models[indexPath.item]["image"]
        cell.layer.cornerRadius = 12
        cell.backgroundColor = cell.cellColor[indexPath.item]
        cell.clipsToBounds = true

        cell.titleLabel.text = cell.models[indexPath.item]["title"]
        cell.descriptionLabel.text = cell.models[indexPath.item]["description"]
        cell.imageView.image = UIImage(named: image!)

        if indexPath.item == 0 {
            cell.titleLabel.textColor = .white
            cell.descriptionLabel.textColor = .white
        }

        return cell
    }

}
