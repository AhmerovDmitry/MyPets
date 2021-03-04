//
//  PetModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.10.2020.
//

import UIKit

struct PetModel: Equatable {
    var image: UIImage?
    var name: String?
    var kind: String?
    var breed: String?
    var birthday: String?
    var weight: String?
    var sterile: String?
    var color: String?
    var hair: String?
    var chipNumber: String?
    
    init(image: UIImage?, name: String?, kind: String?, breed: String?, birthday: String?, weight: String?, sterile: String?, color: String?, hair: String?, chipNumber: String?) {
        self.image = image
        self.name = name
        self.kind = kind
        self.breed = breed
        self.birthday = birthday
        self.weight = weight
        self.sterile = sterile
        self.color = color
        self.hair = hair
        self.chipNumber = chipNumber
    }
    
    init() {
        image = nil
        name = nil
        kind = nil
        breed = nil
        birthday = nil
        weight = nil
        sterile = nil
        color = nil
        hair = nil
        chipNumber = nil
    }
}

struct CollectionModel {
    var image: UIImage?
    var title: String
    var description: String
}
