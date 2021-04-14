//
//  PetClinic+CoreDataProperties.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 14.04.2021.
//
//

import Foundation
import CoreData


extension PetClinic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PetClinic> {
        return NSFetchRequest<PetClinic>(entityName: "PetClinic")
    }

    @NSManaged public var address: String?
    @NSManaged public var doctor: String?
    @NSManaged public var phone: String?
    @NSManaged public var site: String?
    @NSManaged public var pet: PetEntity?

}

extension PetClinic : Identifiable {

}
