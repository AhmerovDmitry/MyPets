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
            return CGSize(width: collectionView.bounds.width / 1.1, height: 475)
        default:
            return CGSize(width: collectionView.bounds.width / 1.1, height: 90)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        collectionModel.count
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellPetId", for: indexPath) as! PetViewCollectionCell
//        cell.titleImage.image = collectionModel[indexPath.item].image
//        cell.menuTitleLabel.text = collectionModel[indexPath.item].title
//        cell.descLabel.text = collectionModel[indexPath.item].description
//        cell.models = [
//            BaseModel(firstProperties: "Кличка", secondProperties: petEntity.name),
//            BaseModel(firstProperties: "Вид", secondProperties: petEntity.kind),
//            BaseModel(firstProperties: "Порода", secondProperties: petEntity.breed),
//            BaseModel(firstProperties: "Дата рождения", secondProperties: petEntity.birthday),
//            BaseModel(firstProperties: "Вес, кг", secondProperties: petEntity.weight),
//            BaseModel(firstProperties: "Стерилизация", secondProperties: petEntity.sterile),
//            BaseModel(firstProperties: "Окрас", secondProperties: petEntity.color),
//            BaseModel(firstProperties: "Шерсть", secondProperties: petEntity.hair),
//            BaseModel(firstProperties: "Номер чипа", secondProperties: petEntity.chipNumber)
//        ]
        
        if indexPath.item == 0 {
            cell.titleImage.isHidden = true
            cell.containerView.isHidden = true
            cell.layer.cornerRadius = 20
            cell.label.isHidden = true
        } else {
            cell.setupMenuCell()
            cell.layer.cornerRadius = 10
//            cell.tableView.isHidden = true
            cell.titleLabel.isHidden = true
        }
        
        let shadowPath = UIBezierPath(rect: cell.bounds).cgPath
        cell.layer.shadowColor = UIColor.CustomColor.dark.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowOpacity = 0.20
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = shadowPath
        cell.layer.shadowRadius = 7
        cell.backgroundColor = .white
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: titleImage.bounds.height / 2.7, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controllers = [HealthController(), DocumentController(), FoodController(), CareController(), EntertainmentController()]
        let titles = ["Здоровье", "Документы", "Питание", "Уход", "Развлечения"]
        
        if indexPath.item != 0 {
//            self.setupBackBarItem()
            self.pushView(controller: controllers[indexPath.item - 1], withTitle: titles[indexPath.item - 1])
        }
    }
}
