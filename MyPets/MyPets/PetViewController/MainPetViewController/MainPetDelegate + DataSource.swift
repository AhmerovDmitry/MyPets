//
//  PetEntityDelegate + DataSource.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 24.02.2021.
//

import UIKit
import RealmSwift

extension MainPetViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width / 1.1, height: view.bounds.height / 3.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "entityCell", for: indexPath) as! EntityCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 15
        cell.imageView.image = pets[indexPath.item].image?.toImage() ?? UIImage(named: "unknownImage")
        cell.nameLabel.text = pets[indexPath.item].name ?? "Кличка не указана"
        cell.breedLabel.text = pets[indexPath.item].breed ?? "Порода не указана"
        cell.ageLabel.text = pets[indexPath.item].birthday ?? "01 янв 1900"
        
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
        petInfoVC.petEntity.image = pets[indexPath.item].image
        petInfoVC.petEntity.name = pets[indexPath.item].name
        petInfoVC.petEntity.kind = pets[indexPath.item].kind
        petInfoVC.petEntity.breed = pets[indexPath.item].breed
        petInfoVC.petEntity.birthday = pets[indexPath.item].birthday
        petInfoVC.petEntity.weight = pets[indexPath.item].weight
        petInfoVC.petEntity.sterile = pets[indexPath.item].sterile
        petInfoVC.petEntity.color = pets[indexPath.item].color
        petInfoVC.petEntity.hair = pets[indexPath.item].hair
        petInfoVC.petEntity.chipNumber = pets[indexPath.item].chipNumber
        petInfoVC.collectionItemIndex = indexPath.item
        
        navigationController?.pushViewController(petInfoVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
    }
    
}

//MARK: - Delegate & CoreData methods
extension MainPetViewController: EntityTransfer {
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func reloadController() {
        self.viewDidLoad()
    }
    
    func loadPets() {
        let _ = pets.realm?.objects(Pet.self)
    }
    
    func createEntity(_ entity: Pet) {
        do {
            try realm.write {
                realm.add(entity)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func updateEntity(_ entity: Pet, at index: Int) {
        do {
            try realm.write {
                realm.delete(pets[index])
                realm.add(entity)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func deleteEntity(at index: Int) {
        do {
            try realm.write {
                realm.delete(pets[index])
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

//MARK: - View settings
extension MainPetViewController {
    func viewWithoutPet() {
        mainStackView.isHidden = false
        collectionView.isHidden = true
        
        navigationItem.rightBarButtonItem = .none
    }
    
    func viewWithPet() {
        mainStackView.isHidden = true
        collectionView.isHidden = false
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(presentController))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.rightBarButtonItem?.tintColor = UIColor.CustomColor.purple
    }
    
}
