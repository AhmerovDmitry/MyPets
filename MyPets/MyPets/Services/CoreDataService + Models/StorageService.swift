//
//  StorageService.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 10.09.2021.
//

import UIKit
import CoreData

protocol CoreDataLoadingServiceProtocol {
    var appDelegate: AppDelegate? { get }
    var context: NSManagedObjectContext? { get }
    var objects: [OMPetInformation] { get set }

    func loadEntitys()
}

protocol CoreDataSavingServiceProtocol {
    func saveEntity(_ entity: PetDTO)
}

protocol CoreDataEditingServiceProtocol {
    func editingEntity(_ entity: PetDTO, at index: Int)
    func removeEntity(at index: Int)
}

protocol FileManagerServiceProtocol {
    func savePhoto(photoID: String, photo: UIImage)
    func loadPhoto(photoID: String) -> UIImage?
    func removePhoto(photoID: String)
}

private protocol SaveContextProtocol {
    func saveContext(_ context: NSManagedObjectContext)
}

protocol ObjectIdentifierProtocol {
    func createIdentifier() -> String
}

typealias StorageServiceProtocol = CoreDataLoadingServiceProtocol & CoreDataSavingServiceProtocol &
    CoreDataEditingServiceProtocol & FileManagerServiceProtocol & ObjectIdentifierProtocol

final class StorageService: CoreDataLoadingServiceProtocol {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    lazy var context: NSManagedObjectContext? = appDelegate?.persistentContainer.viewContext
    var objects: [OMPetInformation] = []
}

// MARK: - Сохранение / загрузка фотографии
extension StorageService: FileManagerServiceProtocol {

    /// Метод сохраняющий фотографию на устройстве
    /// - Parameters:
    ///   - photoID: Индекс сохраняемой фотографии
    ///   - photo: Файл фотографии
    /// - Returns: Путь по которому расположенно изображение
    func savePhoto(photoID: String, photo: UIImage) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first else { return }
        let fileName = "ObjectPhotoUUID_" + photoID
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = photo.jpegData(compressionQuality: 1) else { return }
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }
        do {
            try data.write(to: fileURL)
            print("Photo saved!")
            print(fileURL)
        } catch let error {
            print("error saving file with error", error)
        }
    }

    /// Метод загружающий фотографию из директории устройства
    /// - Parameter photoID: Индекс загружаемой фотографии
    /// - Returns: Загружаемая фотография или nil
    func loadPhoto(photoID: String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent("ObjectPhotoUUID_" + photoID)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        return nil
    }


    /// Метод удаляющий фотографию из директории устройства по индексу
    /// - Parameter photoID: Индекс удаляемой фотографии
    func removePhoto(photoID: String) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first else { return }
        let fileName = "ObjectPhotoUUID_" + photoID
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }
    }
}

// MARK: - Загрузка объектов
extension StorageService {

    /// Загрузка всех объектов из CoreData
    /// происходит в CustomTabBarController
    func loadEntitys() {
        guard let context = context else { return }
        let fetchRequest: NSFetchRequest<OMPetInformation> = OMPetInformation.fetchRequest()
        do {
            objects = try context.fetch(fetchRequest).reversed()
        } catch {
            context.rollback()
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

// MARK: - Сохранение объекта
extension StorageService: CoreDataSavingServiceProtocol {

    /// Сохранение объекта в CoreData
    /// - Parameter entity: Сохраняемый объект
    func saveEntity(_ entity: PetDTO) {
        guard let context = context else { return }
        let entityModel = OMPetInformation(context: context)
        entityModel.update(usingModel: entity)
        saveContext(context)
        loadEntitys()
    }
}

// MARK: - Редактирование / удаление объекта
extension StorageService: CoreDataEditingServiceProtocol {

    /// Редактирование объекта по индексу
    /// - Parameters:
    ///   - entity: Редактируемый объект
    ///   - index: Индекс по которому редактируется объект
    func editingEntity(_ entity: PetDTO, at index: Int) {
        removeEntity(at: index)
        saveEntity(entity)
    }

    /// Удаление объекта по индексу
    /// - Parameter index: Индекс по которому удаляется объект
    func removeEntity(at index: Int) {
        guard let context = context else { return }
        context.delete(objects[index])
        saveContext(context)
        loadEntitys()
    }
}

// MARK: - Сохранение контекста
extension StorageService: SaveContextProtocol {

    /// Сохранение контекста для удобства
    /// - Parameter context: Контекст для сохранения
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
}

// MARK: - Создание уникального идентификатора
extension StorageService: ObjectIdentifierProtocol {
    func createIdentifier() -> String {
        return UUID().uuidString
    }
}
