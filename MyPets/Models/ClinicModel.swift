//
//  ClinicModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.04.2021.
//

import Foundation

struct ClinicModel: Equatable {
    
    var phone: String?
    var address: String?
    var site: String?
    var doctor: String?
    
    init(phone: String?, address: String?, site: String?, doctor: String?) {
        self.phone = phone
        self.address = address
        self.site = site
        self.doctor = doctor
    }
    
    init() {
        phone = nil
        address = nil
        site = nil
        doctor = nil
    }
    
}
