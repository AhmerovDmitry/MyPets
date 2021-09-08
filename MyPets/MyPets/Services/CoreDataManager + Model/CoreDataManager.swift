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
/// Протокол описывающий базовое поведение модели,
/// сохранение, удаление и загрузка
protocol CoreDataManagerProtocol {
    func loadEntitys()
    func createEntity(_ entity: Pet)
    func deleteEntity(at index: Int)
}
/// Приватный протокол для методов которые не должны быть доступны из вне
/// только для внутреннего использования
private protocol PrivateCoreDataManagerProtocol {
    func saveContext(_ context: NSManagedObjectContext)
}

final class CoreDataManager: CoreDataManagerProtocol, PrivateCoreDataManagerProtocol {
    /// Синглтон для удобного обращения к методам (загрузка/создание/удаление/редактирование) сущностей
    /// в рамках одного единственного объекта класса
    static let shared = CoreDataManager()
    private init() {}
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private lazy var context: NSManagedObjectContext? = appDelegate?.persistentContainer.viewContext
    /// Массив объектов, наполняется при запуске приложения,
    /// перезаписывается при сохранении/удалении/редактировании объектов
    private(set) var pets = [OMPetInformation]()
    // MARK: - Загрузка объектов
    /// Публичный метод для загрузки объектов сразу после запуска приложения
    func loadEntitys() {
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
    // MARK: - Сохранение контекста
    fileprivate func saveContext(_ context: NSManagedObjectContext) {
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
    // MARK: - Создание объекта
    func createEntity(_ entity: Pet) {
        guard let context = context else { return }
        let entityModel = OMPetInformation(context: context)
//        entityModel.image = entity.image?.toString()
        entityModel.name = entity.name
        entityModel.kind = entity.kind
        entityModel.breed = entity.breed
        entityModel.birthday = entity.birthday
        entityModel.weight = entity.weight
        entityModel.sterile = entity.sterile
        entityModel.color = entity.color
        entityModel.hair = entity.hair
        entityModel.chipNumber = entity.chipNumber
        /// Сохранение контекста и перезагрузка объектов
        saveContext(context)
        loadEntitys()
    }
    // MARK: - Удаление объекта по индексу нажатой ячейки
    func deleteEntity(at index: Int) {
        guard let context = context else { return }
        context.delete(pets[index])
        /// Сохранение контекста и перезагрузка объектов
        saveContext(context)
        loadEntitys()
    }
}
