//
//  InputInfoPetModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 20.08.2021.
//

import UIKit
import CoreData

struct Pet {
    var image: String
    var name: String
    var kind: String
    var breed: String
    var birthday: String
    var weight: String
    var sterile: String
    var color: String
    var hair: String
    var chipNumber: String
}

final class CoreDataManager {
    let shared = CoreDataManager()
    private init() {}
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
}
extension CoreDataManager {
    public func loadPets() {
//        let fetchRequest: NSFetchRequest<OMPetInformation> = OMPetInformation.fetchRequest()
//        do {
//            try context?.fetch(fetchRequest).reversed()
//        } catch let error {
//            context?.rollback()
//            print(error.localizedDescription)
//        }
    }
    public func createEntity(_ entity: Any) {
        guard let context = context else { return }
        guard let petEntity = NSEntityDescription.entity(forEntityName: "PetEntity", in: context) else { return }
        let petModel = OMPetInformation(entity: petEntity, insertInto: context)
        guard let pet = entity as? Pet else { return }
//        pet.image = entity.image?.toString()
        petModel.name = pet.name
        petModel.kind = pet.kind
        petModel.breed = pet.breed
        petModel.birthday = pet.birthday
        petModel.weight = pet.weight
        petModel.sterile = pet.sterile
        petModel.color = pet.color
        petModel.hair = pet.hair
        petModel.chipNumber = pet.chipNumber
        do {
            try context.save()
        } catch let error {
            context.rollback()
            print(error.localizedDescription)
        }
    }
}
