//
//  PetEntityDelegate + DataSource.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 24.02.2021.
//

import UIKit

extension PetViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 32, height: 234)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return petEntitys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "entityCell", for: indexPath) as! EntityCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 15
        cell.imageView.image = petEntitys[indexPath.item].image ?? UIImage(named: "unknownImage")
        cell.nameLabel.text = petEntitys[indexPath.item].name ?? "Test_text"
        cell.breedLabel.text = petEntitys[indexPath.item].breed ?? "Test_text"
        cell.ageLabel.text = "Test_age"
        
        if cell.imageView.image == UIImage(named: "unknownImage") {
            cell.imageView.contentMode = .scaleAspectFit
        } else {
            cell.imageView.contentMode = .scaleAspectFill
        }
        
        let shadowPath = UIBezierPath(rect: cell.bounds).cgPath
        cell.layer.shadowColor = UIColor.CustomColor.dark.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowOpacity = 0.20
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = shadowPath
        cell.layer.shadowRadius = 7
        cell.backgroundColor = .white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
    }
}
