//
//  StorageService.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 10.09.2021.
//

import UIKit
import CoreData

protocol FMRepository {
    func removeItem(atPath path: String) throws
    func urls(for directory: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask) -> [URL]
    func fileExists(atPath path: String) -> Bool
}

extension FileManager: FMRepository {}

protocol CoreDataLoadingService {
    var appDelegate: AppDelegate? { get }
    var context: NSManagedObjectContext? { get }
    var objects: [OMPetInformation] { get set }

    func loadEntitys()
}

protocol CoreDataSavingService {
    func saveEntity(_ entity: PetDTO)
}

protocol CoreDataEditingService {
    func editingEntity(_ entity: PetDTO, at index: Int)
    func removeEntity(at index: Int)
}

protocol FileManagerService {
    func loadPhoto(photoID: String) -> UIImage?
    func savePhoto(photoID: String, photo: UIImage)
    func removePhoto(photoID: String)
}

protocol SaveContext {
    func saveContext(_ context: NSManagedObjectContext)
}

protocol ObjectIdentifier {
    var identifier: String { get }
}

typealias StorageService = CoreDataLoadingService & CoreDataSavingService &
    CoreDataEditingService & FileManagerService & SaveContext & ObjectIdentifier

final class StorageServiceImpl: StorageService {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    lazy var context: NSManagedObjectContext? = appDelegate?.persistentContainer.viewContext
    var objects: [OMPetInformation] = []

    private var repository: FMRepository

    init(repository: FMRepository) {
        self.repository = repository
    }
}

// MARK: - Загрузка / сохранение / удаление фотографий
extension StorageServiceImpl {
    /// Метод загружающий фотографию из директории устройства
    /// - Parameter photoID: Индекс загружаемой фотографии
    /// - Returns: Загружаемая фотография или nil
    func loadPhoto(photoID: String) -> UIImage? {
        guard let documentsDirectory = FileManager.default.urls(
                for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileName = photoID
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if let image = UIImage(contentsOfFile: fileURL.path) {
            return image
        }
        return nil
    }
    /// Метод сохраняющий фотографию на устройстве
    /// - Parameters:
    ///   - photoID: Индекс сохраняемой фотографии
    ///   - photo: Файл фотографии
    /// - Returns: Путь по которому расположенно изображение
    func savePhoto(photoID: String, photo: UIImage) {
        guard let documentsDirectory = FileManager.default.urls(
                for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileName = photoID
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = photo.jpegData(compressionQuality: 1) else { return }
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch let removeError {
                debugPrint("По указанному пути файл не найден:", removeError)
            }
        }
        do {
            try data.write(to: fileURL)
        } catch let error {
            debugPrint("Ошибка сохранения файла:", error)
        }
    }
    /// Метод удаляющий фотографию из директории устройства по индексу
    /// - Parameter photoID: Индекс удаляемой фотографии
    func removePhoto(photoID: String) {
        guard let documentsDirectory = FileManager.default.urls(
                for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileName = photoID
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}

// MARK: - Загрузка объектов
extension StorageServiceImpl {
    /// Загрузка всех объектов из CoreData
    /// происходит в CustomTabBarController
    func loadEntitys() {
        guard let context = context else { return }
        let fetchRequest: NSFetchRequest<OMPetInformation> = OMPetInformation.fetchRequest()
        do {
            objects = try context.fetch(fetchRequest).sorted(by: { $0.createDate > $1.createDate })
        } catch {
            context.rollback()
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

// MARK: - Сохранение объекта
extension StorageServiceImpl {
    /// Сохранение объекта в CoreData
    /// - Parameter entity: Сохраняемый объект
    func saveEntity(_ entity: PetDTO) {
        guard let context = context else { return }
        let entityModel = OMPetInformation(context: context)
        entityModel.createDate = Date()
        entityModel.update(usingModel: entity)
        saveContext(context)
        loadEntitys()
    }
}

// MARK: - Редактирование / удаление объекта
extension StorageServiceImpl {
    /// Редактирование объекта по индексу
    /// - Parameters:
    ///   - entity: Редактируемый объект
    ///   - index: Индекс по которому редактируется объект
    func editingEntity(_ entity: PetDTO, at index: Int) {
        guard let context = context else { return }
        objects[index].update(usingModel: entity)
        saveContext(context)
        loadEntitys()
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
extension StorageServiceImpl {
    /// Сохранение контекста для удобства
    /// - Parameter context: Контекст для сохранения
    func saveContext(_ context: NSManagedObjectContext) {
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
extension StorageServiceImpl {
    var identifier: String {
        return UUID().uuidString
    }
}
