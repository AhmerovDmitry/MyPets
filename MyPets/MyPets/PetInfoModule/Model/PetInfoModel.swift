//
//  PetInfoModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.08.2021.
//

import UIKit

struct PetInfoModel {
    // MARK: - Properties
    weak var controller: PetInfoController?
    public let menuTitles = [
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
    private(set) var petInformation: [String?] = [nil,
                                                  nil,
                                                  nil,
                                                  nil,
                                                  nil,
                                                  nil,
                                                  nil,
                                                  nil,
                                                  nil] {
        didSet {
            print("RELOAD_TABLEVIEW")
            controller?.reloadTableViewData(self)
        }
    }
    private(set) var defaultPet = Pet(image: nil,
                                      name: nil,
                                      kind: nil,
                                      breed: nil,
                                      birthday: nil,
                                      weight: nil,
                                      sterile: nil,
                                      color: nil,
                                      hair: nil,
                                      chipNumber: nil) {
        didSet {
            print("RELOAD_TABLEVIEW")
            controller?.reloadTableViewData(self)
        }
    }
    // MARK: - Methods
    public mutating func updateInformation(_ info: String, index: Int) {
        petInformation[index] = info
        switch index {
        case 0: defaultPet.name = info
        case 1: defaultPet.kind = info
        case 2: defaultPet.breed = info
        case 3: defaultPet.birthday = info
        case 4: defaultPet.weight = info
        case 5: defaultPet.sterile = info
        case 6: defaultPet.color = info
        case 7: defaultPet.hair = info
        case 8: defaultPet.chipNumber = info
        default:
            defaultPet.image = info
        }
    }
}
