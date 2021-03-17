//
//  PetEntityDelegate + DataSource.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 24.02.2021.
//

import UIKit

extension MainPetViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width / 1.1, height: view.bounds.height / 3.5)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return petEntitys.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "entityCell", for: indexPath) as! EntityCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 15
        cell.imageView.image = petEntitys[indexPath.item].image ?? UIImage(named: "unknownImage")
        cell.nameLabel.text = petEntitys[indexPath.item].name ?? "Кличка не указана"
        cell.breedLabel.text = petEntitys[indexPath.item].breed ?? "Порода не указана"
        cell.ageLabel.text = petEntitys[indexPath.item].birthday ?? "01 янв 1900"

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
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem

        let petInfoVC = PetInfoViewController()
        petInfoVC.hidesBottomBarWhenPushed = true
        petInfoVC.delegate = self
        petInfoVC.petEntity = petEntitys[indexPath.item]
        if !petEntitys.isEmpty {
            petInfoVC.collectionItemIndex = indexPath.item
        }
        navigationController?.pushViewController(petInfoVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
    }

}
