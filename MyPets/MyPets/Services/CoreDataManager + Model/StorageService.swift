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
//    func loadEntity(at index: Int)
}

protocol CoreDataSavingServiceProtocol {
    func saveEntity(_ entity: OMPetInformation)
}

protocol CoreDataEditingServiceProtocol {
//    func editingEntity(_ entity: OMPetInformation, at index: Int?)
    func removeEntity(at index: Int)
}

protocol FileManagerServiceProtocol {
    var photoName: String { get }
    func savePhoto(photoName: String, _ photo: UIImage) -> String?
    func loadPhoto(photoName: String) -> UIImage?
}

private protocol SaveContextProtocol {
    func saveContext(_ context: NSManagedObjectContext)
}

typealias StorageServiceProtocol = CoreDataLoadingServiceProtocol & CoreDataSavingServiceProtocol & CoreDataEditingServiceProtocol & FileManagerServiceProtocol

final class StorageService: CoreDataLoadingServiceProtocol {
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context: NSManagedObjectContext? = appDelegate?.persistentContainer.viewContext
    var objects: [OMPetInformation] = []
}

extension StorageService: FileManagerServiceProtocol {
    var photoName: String {
        return "ObjectPhotoNumberInLibrary_"
    }

    /// Метод сохраняющий фотографию на устройстве
    /// - Parameters:
    ///   - photoName: Имя фотографии на устройстве
    ///   - photo: Файл фотографии
    /// - Returns: Путь по которому расположенно изображение
    func savePhoto(photoName: String, _ photo: UIImage) -> String? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first else { return nil }
        let fileName = photoName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = photo.jpegData(compressionQuality: 1) else { return nil }
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
            return fileURL.path
        } catch let error {
            print("error saving file with error", error)
        }
        return nil
    }

    /// Метод загружающий фотографию из директории устройства
    /// - Parameter photoName: Имя загружаемой фотографии
    /// - Returns: Загружаемая фотография или nil
    func loadPhoto(photoName: String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(photoName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        return nil
    }
}

extension StorageService {

    /// Загрузка всех объектов из CoreData
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

    /*
    /// Загрузка одного объекта из CoreData (или из всех ранее загруженных объектов)
    /// - Parameter index: Индекс по которому загружается объект
    func loadEntity(at index: Int) {}
    */
}

extension StorageService: CoreDataSavingServiceProtocol {

    /// Сохранение объекта в CoreData
    func saveEntity(_ entity: OMPetInformation) {
        guard let context = context else { return }
        let entityModel = OMPetInformation(context: context)
        entityModel.name = entity.name
        entityModel.kind = entity.kind
        entityModel.breed = entity.breed
        entityModel.birthday = entity.birthday
        entityModel.weight = entity.weight
        entityModel.sterile = entity.sterile
        entityModel.color = entity.color
        entityModel.hair = entity.hair
        entityModel.chipNumber = entity.chipNumber
        entityModel.image = entity.image
        saveContext(context)
        loadEntitys()
    }
}

extension StorageService: CoreDataEditingServiceProtocol {

    /*
    /// Редактирование объекта по индексу
    /// - Parameter index: Индекс по которому редактируется объект
    func editingEntity(_ entity: OMPetInformation, at index: Int? = nil) {
        // FIXIT: - РЕДАКТИРОВАНИЕ!
    }
    */

    /// Удаление объекта по индексу
    /// - Parameter index: Индекс по которому удаляется объект
    func removeEntity(at index: Int) {
        guard let context = context else { return }
        context.delete(objects[index])
        saveContext(context)
        loadEntitys()
    }
}

extension StorageService: SaveContextProtocol {

    /// Сохранение контекста для удобства
    /// - Parameter context: Контекст для осхранения
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
