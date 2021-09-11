//
//  OMPetInformation+CoreDataClass.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.09.2021.
//
//

import Foundation
import CoreData

@objc(OMPetInformation)
public class OMPetInformation: NSManagedObject {

}

extension OMPetInformation {
    func update(usingModel model: PetDTO) {
        self.name = model.name
        self.kind = model.kind
        self.breed = model.breed
        self.birthday = model.birthday
        self.weight = model.weight
        self.sterile = model.sterile
        self.color = model.color
        self.hair = model.hair
        self.chipNumber = model.chipNumber
        self.identifier = model.identifier
    }
}
