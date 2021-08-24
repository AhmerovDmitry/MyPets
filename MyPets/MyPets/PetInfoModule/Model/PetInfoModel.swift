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
    private(set) var petInformation: [String?] = [nil, nil, nil, nil, nil, nil, nil, nil, nil] {
        didSet {
            controller?.reloadTableViewData(self)
        }
    }
    // MARK: - Methods
    public mutating func updateInformation(_ info: String, index: Int) {
        petInformation[index] = info
    }
}
