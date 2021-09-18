//
//  PetInfoModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.08.2021.
//

import UIKit

final class PetInfoModel {
    private let storageService: StorageService
    private(set) var objectForFilling: PetDTO

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

    // Решил разгрузить контроллер и вынес логику storageService в модель

    init(storageService: StorageService, cellIndex: Int?) {
        self.storageService = storageService

        if let index = cellIndex {
            self.objectForFilling = PetDTO(identifier: storageService.objects[index].identifier)

            self.objectForFilling.name = storageService.objects[index].name
            self.objectForFilling.kind = storageService.objects[index].kind
            self.objectForFilling.breed = storageService.objects[index].breed
            self.objectForFilling.birthday = storageService.objects[index].birthday
            self.objectForFilling.weight = storageService.objects[index].weight
            self.objectForFilling.sterile = storageService.objects[index].sterile
            self.objectForFilling.color = storageService.objects[index].color
            self.objectForFilling.hair = storageService.objects[index].hair
            self.objectForFilling.chipNumber = storageService.objects[index].chipNumber
            self.objectForFilling.photo = storageService.loadPhoto(photoID: self.objectForFilling.identifier)
        } else {
            self.objectForFilling = PetDTO(identifier: storageService.identifier)

            self.objectForFilling.name = nil
            self.objectForFilling.kind = nil
            self.objectForFilling.breed = nil
            self.objectForFilling.birthday = nil
            self.objectForFilling.weight = nil
            self.objectForFilling.sterile = nil
            self.objectForFilling.color = nil
            self.objectForFilling.hair = nil
            self.objectForFilling.chipNumber = nil
            self.objectForFilling.photo = nil
        }
    }
}

extension PetInfoModel {
    func saveObject() {
        storageService.saveEntity(objectForFilling)
        if let photo = objectForFilling.photo {
            storageService.savePhoto(photoID: objectForFilling.identifier, photo: photo)
        }
    }
    func removeObject(at index: Int) {
        storageService.removeEntity(at: index)
        if objectForFilling.photo != nil {
            storageService.removePhoto(photoID: objectForFilling.identifier)
        }
    }
    func editedObject(at index: Int) {
        storageService.editingEntity(objectForFilling, at: index)
        if let photo = objectForFilling.photo {
            storageService.savePhoto(photoID: objectForFilling.identifier, photo: photo)
        }
    }
    func loadPhoto() -> UIImage? {
        return storageService.loadPhoto(photoID: objectForFilling.identifier)
    }
}

extension PetInfoModel {
    func changeObjectInformation(at  index: Int, _ information: String?) {
        let info: String?
        if information == "" {
            info = nil
        } else {
            info = information
        }
        switch index {
        case 0: objectForFilling.name = info
        case 1: objectForFilling.kind = info
        case 2: objectForFilling.breed = info
        case 3: objectForFilling.birthday = info
        case 4: objectForFilling.weight = info
        case 5: objectForFilling.sterile = info
        case 6: objectForFilling.color = info
        case 7: objectForFilling.hair = info
        case 8: objectForFilling.chipNumber = info
        default: break
        }
    }
    func changeObjectPhoto(_ photo: UIImage) {
        objectForFilling.photo = photo
    }
    func isObjectNil() -> Bool {
        let nilObject = PetDTO(identifier: "")
        if  objectForFilling.name == nilObject.name && objectForFilling.kind == nilObject.kind &&
                objectForFilling.breed == nilObject.breed && objectForFilling.birthday == nilObject.birthday &&
                objectForFilling.weight == nilObject.weight && objectForFilling.sterile == nilObject.sterile &&
                objectForFilling.color == nilObject.color && objectForFilling.hair == nilObject.hair &&
                objectForFilling.chipNumber == nilObject.chipNumber {
            return true
        }
        return false
    }
}
