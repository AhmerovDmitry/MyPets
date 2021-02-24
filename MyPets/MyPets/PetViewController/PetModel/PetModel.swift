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
    var birthday: Date?
    var weight: String?
    var sterile: String?
    var color: String?
    var hair: String?
    var chipNumber: String?
}

struct CollectionModel {
    var image: UIImage?
    var title: String
    var description: String
}
