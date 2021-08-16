//
//  PetEntityDelegate + DataSource.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 24.02.2021.
//

import UIKit
import CoreData

extension MainPetViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return pets.count
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "entityCell", for: indexPath) as! EntityCell
//        cell.backgroundColor = .white
//        cell.layer.cornerRadius = 15
//        cell.imageView.image = pets[indexPath.item].image?.toImage() ?? UIImage(named: "unknownImage")
//        cell.nameLabel.text = pets[indexPath.item].name ?? "Кличка не указана"
//        cell.breedLabel.text = pets[indexPath.item].breed ?? "Порода не указана"
//        cell.ageLabel.text = pets[indexPath.item].birthday ?? "01 янв 1900"
//
//        if cell.imageView.image == UIImage(named: "unknownImage") {
//            cell.imageView.contentMode = .scaleAspectFit
//        } else {
//            cell.imageView.contentMode = .scaleAspectFill
//        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        
        let petInfoVC = PetInfoViewController()
        petInfoVC.hidesBottomBarWhenPushed = true
//        petInfoVC.delegate = self
//        petInfoVC.petEntity.image = pets[indexPath.item].image?.toImage()
//        petInfoVC.petEntity.name = pets[indexPath.item].name
//        petInfoVC.petEntity.kind = pets[indexPath.item].kind
//        petInfoVC.petEntity.breed = pets[indexPath.item].breed
//        petInfoVC.petEntity.birthday = pets[indexPath.item].birthday
//        petInfoVC.petEntity.weight = pets[indexPath.item].weight
//        petInfoVC.petEntity.sterile = pets[indexPath.item].sterile
//        petInfoVC.petEntity.color = pets[indexPath.item].color
//        petInfoVC.petEntity.hair = pets[indexPath.item].hair
//        petInfoVC.petEntity.chipNumber = pets[indexPath.item].chipNumber
        petInfoVC.collectionItemIndex = indexPath.item
        navigationController?.pushViewController(petInfoVC, animated: true)
    }
}

// MARK: - Delegate & CoreData methods
//extension MainPetViewController: EntityTransfer {
//    func reloadCollectionView() {
//        collectionView.reloadData()
//    }
//
//    func reloadController() {
//        self.viewDidLoad()
//    }
//
//    func loadPets() {
//        let fetchRequest: NSFetchRequest<PetEntity> = PetEntity.fetchRequest()
//
//        do {
//            pets = try context.fetch(fetchRequest).reversed()
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//
//    func createEntity(_ entity: Any) {
//        guard let petEnt = NSEntityDescription.entity(forEntityName: "PetEntity", in: context) else { return }
//        let pet = PetEntity(entity: petEnt, insertInto: context)
//        let entity = entity as! Pet
//        pet.image = entity.image?.toString()
//        pet.name = entity.name
//        pet.kind = entity.kind
//        pet.breed = entity.breed
//        pet.birthday = entity.birthday
//        pet.weight = entity.weight
//        pet.sterile = entity.sterile
//        pet.color = entity.color
//        pet.hair = entity.hair
//        pet.chipNumber = entity.chipNumber
//
//        do {
//            pets.insert(pet, at: 0)
//            try context.save()
//        } catch let error {
//            context.rollback()
//            print(error.localizedDescription)
//        }
//    }
//
//    func updateEntity(_ entity: Any, at indexPath: Int) {
//        guard let petEnt = NSEntityDescription.entity(forEntityName: "PetEntity", in: context) else { return }
//        let pet = PetEntity(entity: petEnt, insertInto: context)
//        let entity = entity as! Pet
//        pet.image = entity.image?.toString()
//        pet.name = entity.name
//        pet.kind = entity.kind
//        pet.breed = entity.breed
//        pet.birthday = entity.birthday
//        pet.weight = entity.weight
//        pet.sterile = entity.sterile
//        pet.color = entity.color
//        pet.hair = entity.hair
//        pet.chipNumber = entity.chipNumber
//
//        context.delete(pets[indexPath])
//        do {
//            pets.remove(at: indexPath)
//            pets.insert(pet, at: indexPath)
//            try context.save()
//        } catch let error {
//            context.rollback()
//            print(error.localizedDescription)
//        }
//    }
//
//    func deleteEntity(at index: Int) {
//        context.delete(pets[index])
//        do {
//            try context.save()
//            pets.remove(at: index)
////            collectionView.reloadData()
//        } catch let error {
//            context.rollback()
//            print(error.localizedDescription)
//        }
//    }
//}
