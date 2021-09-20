//
//  OMPetInformation+CoreDataProperties.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.09.2021.
//
//

import Foundation
import CoreData

extension OMPetInformation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OMPetInformation> {
        return NSFetchRequest<OMPetInformation>(entityName: "OMPetInformation")
    }

    @NSManaged public var birthday: String?
    @NSManaged public var breed: String?
    @NSManaged public var chipNumber: String?
    @NSManaged public var color: String?
    @NSManaged public var hair: String?
    @NSManaged public var kind: String?
    @NSManaged public var name: String?
    @NSManaged public var sterile: String?
    @NSManaged public var weight: String?
    @NSManaged public var identifier: String
    @NSManaged public var createDate: Date

}

extension OMPetInformation: Identifiable {

}
