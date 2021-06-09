//
//  Clinic.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.04.2021.
//

import UIKit
import RealmSwift

class Clinic: Object {
    @objc dynamic var phone: String?
    @objc dynamic var address: String?
    @objc dynamic var site: String?
    @objc dynamic var doctor: String?
    @objc dynamic var pet: Pet?
}
