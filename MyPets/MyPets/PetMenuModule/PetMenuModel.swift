//
//  PetMenuModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.09.2021.
//

import Foundation

protocol PetMenuProtocol {
}

extension PetMenuProtocol {
    var defaultName: String {
        return "Кличка не указана"
    }
    var defaultBreed: String {
        return "Порода не указана"
    }
    var defaultBirthday: String {
        return "01.01.1001"
    }
}

final class PetMenuModel: PetMenuProtocol {
    let controllerTitle = "Питомцы"
}
