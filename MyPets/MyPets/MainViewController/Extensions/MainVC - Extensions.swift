//
//  MainVC - Extensions.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.04.2021.
//

import UIKit

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: UIScreen.main.bounds.height / 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! MainCollectionCell
        cell.layer.cornerRadius = 12
        cell.backgroundColor = UIColor.CustomColor.lightGray2
        cell.clipsToBounds = true
        cell.bottomCollectionView.isHidden = true
        
        if indexPath.item == 1 {
            cell.imageView.isHidden = true
            cell.titleLabel.isHidden = true
            cell.descriptionLabel.isHidden = true
            cell.bottomCollectionView.isHidden = false
        }
        
        return cell
    }
    
}
