//
//  PetInfoModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.08.2021.
//

import UIKit
import CoreData

struct PetObject: Equatable {
    var name: String?
    var kind: String?
    var breed: String?
    var birthday: String?
    var weight: String?
    var sterile: String?
    var color: String?
    var hair: String?
    var chipNumber: String?
    var photoUrl: String?
}

struct PetInfoModel {

    /// Массив со стройками которые заполняют тайтл ячейки таблицы
    let menuTitles = [
        "Кличка",
        "Вид",
        "Порода",
        "Дата рождения",
        "Вес, кг",
        "Стерилизация",
        "Окрас",
        "Шерсть",
        "Номер чипа"
    ]

    /// Перечисление действий с объектом
    enum StorageServiceAction {
        case saveObject, deleteObject, editedObject
    }

    /// Подготовка объекта и работа с CoreData
    /// - Parameters:
    ///   - action: Действие над объектом
    ///   - entity: Объект
    ///   - entityIndex: Индекс объекта, стандартный индекс равен 0
    ///   - storageService: Сервис работы с памятью
    func prepareObject(forAction action: StorageServiceAction, entity: PetObject,
                       entityIndex: Int = 0, storageService: StorageServiceProtocol) {
        guard let context = storageService.context else { return }
            let object = OMPetInformation(context: context)
            object.name = entity.name
            object.kind = entity.kind
            object.breed = entity.breed
            object.birthday = entity.birthday
            object.weight = entity.weight
            object.sterile = entity.sterile
            object.color = entity.color
            object.hair = entity.hair
            object.chipNumber = entity.chipNumber
            object.image = entity.photoUrl

        switch action {
        case .saveObject:
            storageService.saveEntity(object)
        case .deleteObject:
            storageService.removeEntity(at: entityIndex)
        case .editedObject:
            storageService.editingEntity(object, at: entityIndex)
        }
    }
}
