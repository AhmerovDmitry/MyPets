//
//  EntitysModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.09.2021.
//

import UIKit

final class EntitysModel: PetMenuProtocol {
    private let storageService: StorageService

    init(storageService: StorageService) {
        self.storageService = storageService
    }

    func removeObject(at index: Int) {
        if storageService.loadPhoto(photoID: storageService.objects[index].identifier) != nil {
            storageService.removePhoto(photoID: storageService.objects[index].identifier)
        }
        storageService.removeEntity(at: index)
    }
    func getObjects() -> [OMPetInformation] {
        return storageService.objects
    }
}
