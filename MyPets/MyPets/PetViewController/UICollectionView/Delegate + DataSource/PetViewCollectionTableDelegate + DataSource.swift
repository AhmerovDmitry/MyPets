//
//  PetViewCollectionDelegate + DataSource.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.10.2020.
//

import UIKit

extension PetInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.item {
        case 0:
            return CGSize(width: collectionView.bounds.width - 32, height: 475)
        default:
            return CGSize(width: collectionView.bounds.width - 32, height: 90)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellPetId", for: indexPath) as! PetViewCollectionCell
        
        if indexPath.row == 0 {
            cell.layer.cornerRadius = 20
            cell.label.isHidden = true
        } else {
            cell.layer.cornerRadius = 10
            cell.tableView.isHidden = true
            cell.titleLabel.isHidden = true
        }
        
        let shadowPath = UIBezierPath(rect: cell.bounds).cgPath
        cell.layer.shadowColor = UIColor.CustomColor.dark.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowOpacity = 0.20
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = shadowPath
        cell.layer.shadowRadius = 7.5
        cell.backgroundColor = .white
        
        cell.isSelected = false
        
        cell.delegate = self
        
        return cell
    }
}
