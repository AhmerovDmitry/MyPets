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
        return "00.00.00"
    }
}

final class PetMenuModel: PetMenuProtocol {
    let controllerTitle = "Питомцы"
}
