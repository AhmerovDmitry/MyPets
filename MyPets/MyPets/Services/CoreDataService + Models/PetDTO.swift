//
//  PetDTO.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.09.2021.
//

import UIKit

struct PetDTO: Equatable {
    var name: String?
    var kind: String?
    var breed: String?
    var birthday: String?
    var weight: String?
    var sterile: String?
    var color: String?
    var hair: String?
    var chipNumber: String?
    var photo: UIImage?
    var identifier: String
}
