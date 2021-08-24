//
//  FoodDelegate + DataSource.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 05.03.2021.
//

import UIKit

extension FoodController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 1.1, height: 90)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "foodCellId",
            for: indexPath
        ) as? MenuCell else { return UICollectionViewCell() }
        cell.titleImage.image = UIImage(named: "foodIcon")
        cell.menuTitleLabel.text = models[indexPath.item].firstProperties
        cell.descLabel.text = models[indexPath.item].secondProperties
        return cell
    }
}
