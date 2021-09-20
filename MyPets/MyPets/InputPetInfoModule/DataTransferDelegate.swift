//
//  DataTransferProtocol.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 18.09.2021.
//

import Foundation

protocol DataTransferDelegate: AnyObject {
    func dismissController()
    func transferInformation(_ info: Any?)
    func setDateForDatePicker() -> Date
}

extension DataTransferDelegate {
    func setDateForDatePicker() -> Date { Date() }
}
