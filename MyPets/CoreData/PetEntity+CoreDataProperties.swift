//
//  PetEntity+CoreDataProperties.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 14.04.2021.
//
//

import Foundation
import CoreData


extension PetEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PetEntity> {
        return NSFetchRequest<PetEntity>(entityName: "PetEntity")
    }

    @NSManaged public var attribute: String?
    @NSManaged public var birthday: String?
    @NSManaged public var breed: String?
    @NSManaged public var chipNumber: String?
    @NSManaged public var color: String?
    @NSManaged public var hair: String?
    @NSManaged public var image: String?
    @NSManaged public var kind: String?
    @NSManaged public var name: String?
    @NSManaged public var sterile: String?
    @NSManaged public var weight: String?
    @NSManaged public var clinic: PetClinic?

}

extension PetEntity : Identifiable {

}
