//
//  CoreDataManager.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 24.08.2021.
//

import UIKit
import CoreData

struct Pet {
    var image: String?
    var name: String?
    var kind: String?
    var breed: String?
    var birthday: String?
    var weight: String?
    var sterile: String?
    var color: String?
    var hair: String?
    var chipNumber: String?
}

final class CoreDataManager {
    /// Синглтон для удобного обращения к методам (загрузка/создание/удаление/редактирование) сущностей
    static let shared = CoreDataManager()
    private init() {}
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private lazy var context: NSManagedObjectContext? = appDelegate?.persistentContainer.viewContext
    /// Массив питомцев, наполняется при запуске приложения
    private(set) var pets = [OMPetInformation]()
    // MARK: - Methods
    public func loadPets() {
        guard let context = context else { return }
        let fetchRequest: NSFetchRequest<OMPetInformation> = OMPetInformation.fetchRequest()
        do {
            pets = try context.fetch(fetchRequest).reversed()
            print(pets.map { $0.name })
        } catch {
            context.rollback()
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    public func createEntity(_ entity: Pet) {
        guard let context = context else { return }
        let petModel = OMPetInformation(context: context)
//        pet.image = entity.image?.toString()
        petModel.name = entity.name
        petModel.kind = entity.kind
        petModel.breed = entity.breed
        petModel.birthday = entity.birthday
        petModel.weight = entity.weight
        petModel.sterile = entity.sterile
        petModel.color = entity.color
        petModel.hair = entity.hair
        petModel.chipNumber = entity.chipNumber
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
//    public func updateEntity(_ entity: Any, at indexPath: Int) {
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
    public func deleteEntity(at index: Int) {
        guard let context = context else { return }
        context.delete(pets[index])
        do {
            try context.save()
            pets.remove(at: index)
        } catch let error {
            context.rollback()
            print(error.localizedDescription)
        }
    }
}
