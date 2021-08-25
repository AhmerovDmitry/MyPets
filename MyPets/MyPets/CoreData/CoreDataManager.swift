//
//  CoreDataManager.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 24.08.2021.
//

import UIKit
import CoreData

struct Pet: Equatable {
    var name: String?
    var kind: String?
    var breed: String?
    var birthday: String?
    var weight: String?
    var sterile: String?
    var color: String?
    var hair: String?
    var chipNumber: String?
    var image: String?
}

final class CoreDataManager {
    /// Синглтон для удобного обращения к методам (загрузка/создание/удаление/редактирование) сущностей
    static let shared = CoreDataManager()
    private init() {}
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private lazy var context: NSManagedObjectContext? = appDelegate?.persistentContainer.viewContext
    /// Массив объектов, наполняется при запуске приложения,
    /// перезаписывается при сохранении/удалении/редактировании объектов
    private(set) var pets = [OMPetInformation]()
    // MARK: - Загрузка объектов
    public func loadEntitys() {
        guard let context = context else { return }
        let fetchRequest: NSFetchRequest<OMPetInformation> = OMPetInformation.fetchRequest()
        do {
            pets = try context.fetch(fetchRequest).reversed()
        } catch {
            context.rollback()
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    // MARK: - Создание объекта
    /// При создании сущность заполняется основываясь на данные которые ввел пользователь
    /// Если сущность сщщтветствует nilEntity(сущность с пустыми полями), тогда она не будет создаваться
    /// Для создания сущности требуется казать хотя бы 1 поле из всего списка
    public func createEntity(_ entity: Pet) {
        let nilEntity = Pet()
        if entity != nilEntity {
            guard let context = context else { return }
            let petModel = OMPetInformation(context: context)
//            pet.image = entity.image?.toString()
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
            /// Происходит перезагрузка объектов из CoreData для повторного заполнения массива с измененными данными
            loadEntitys()
        }
    }
    // MARK: - Удаление объекта по индексу нажатой ячейки
    public func deleteEntity(at index: Int) {
        if pets.count - 1 >= index {
            guard let context = context else { return }
            context.delete(pets[index])
            do {
                try context.save()
                pets.remove(at: index)
            } catch let error {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            /// Происходит перезагрузка объектов из CoreData для повторного заполнения массива с измененными данными
            loadEntitys()
        }
    }
}
