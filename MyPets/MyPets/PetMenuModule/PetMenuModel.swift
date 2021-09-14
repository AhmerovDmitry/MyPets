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
        get { "Кличка не указана" }
    }
    var defaultBreed: String {
        get { "Порода не указана" }
    }
    var defaultBirthday: String {
        get { "01.01.1001" }
    }
}

final class PetMenuModel: PetMenuProtocol {
    let controllerTitle = "Питомцы"
}
