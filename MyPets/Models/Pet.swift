//
//  Pet.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.10.2020.
//

import UIKit
import RealmSwift

class Pet: Object {
    @objc dynamic var image: String?
    @objc dynamic var name: String?
    @objc dynamic var kind: String?
    @objc dynamic var breed: String?
    @objc dynamic var birthday: String?
    @objc dynamic var weight: String?
    @objc dynamic var sterile: String?
    @objc dynamic var color: String?
    @objc dynamic var hair: String?
    @objc dynamic var chipNumber: String?
    @objc dynamic var clinic: Clinic?
    
//    init(image: String?, name: String?, kind: String?, breed: String?, birthday: String?, weight: String?, sterile: String?, color: String?, hair: String?, chipNumber: String?, clinic: Clinic?) {
//        self.image = image
//        self.name = name
//        self.kind = kind
//        self.breed = breed
//        self.birthday = birthday
//        self.weight = weight
//        self.sterile = sterile
//        self.color = color
//        self.hair = hair
//        self.chipNumber = chipNumber
//        self.clinic = clinic
//    }
    
    public static func ==(lhs: Pet, rhs: Pet) -> Bool{
        return
            lhs.image == rhs.image &&
            lhs.name == rhs.name &&
            lhs.kind == rhs.kind &&
            lhs.breed == rhs.breed &&
            lhs.birthday == rhs.birthday &&
            lhs.weight == rhs.weight &&
            lhs.sterile == rhs.sterile &&
            lhs.color == rhs.color &&
            lhs.hair == rhs.hair &&
            lhs.chipNumber == rhs.chipNumber
    }
}
