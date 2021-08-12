//
//  MainCell - Extension.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.04.2021.
//

import UIKit

extension MainCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.bounds.width / 1.35, height: UIScreen.main.bounds.height / 6.1)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "bottomCell",
            for: indexPath
        ) as? BottomMenuCell else { return UICollectionViewCell() }
        let image = cell.models[indexPath.item]["image"]
        cell.layer.cornerRadius = 12
        cell.backgroundColor = cell.cellColor[indexPath.item]
        cell.clipsToBounds = true

        cell.titleLabel.text = cell.models[indexPath.item]["title"]
        cell.descriptionLabel.text = cell.models[indexPath.item]["description"]
        if let image = image {
            cell.imageView.image = UIImage(named: image)
        }

        if indexPath.item == 0 {
            cell.titleLabel.textColor = .white
            cell.descriptionLabel.textColor = .white
        }

        return cell
    }
}
