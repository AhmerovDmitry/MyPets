//
//  LocationViewControllerDelegate + DataSource.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 22.10.2020.
//

import UIKit

extension LocationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = models[indexPath.row]
        let itemSize = item.text.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)])

        return CGSize(width: itemSize.width + 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFilterId", for: indexPath) as! LocationViewCell
        let data = models[indexPath.item]
        cell.model = data
        
        return cell
    }
}
