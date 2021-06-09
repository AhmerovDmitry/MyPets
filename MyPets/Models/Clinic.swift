//
//  Clinic.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.04.2021.
//

//import UIKit
//
//class Clinic: Object {
//    @objc dynamic var phone: String?
//    @objc dynamic var address: String?
//    @objc dynamic var site: String?
//    @objc dynamic var doctor: String?
//    @objc dynamic var pet: Pet?
//}

import Foundation
import CoreData

@objc(PetClinic)
public class PetClinic: NSManagedObject {

}

extension PetClinic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PetClinic> {
        return NSFetchRequest<PetClinic>(entityName: "PetClinic")
    }

    @NSManaged public var address: String?
    @NSManaged public var doctor: String?
    @NSManaged public var phone: String?
    @NSManaged public var site: String?
    @NSManaged public var pet: Pet?

}

extension PetClinic : Identifiable {

}
