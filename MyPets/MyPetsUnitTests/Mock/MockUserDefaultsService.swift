//
//  MockUserDefaultsService.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 17.09.2021.
//

import Foundation

class MockUserDefaultsService: UserDefaultsService {
    var storage: [String: Bool] = [:]

    func value(forKey key: KeyRawValue) -> Bool {
        guard let value = storage[key.description] else { return false }
        return value
    }
    func setValue(_ value: Bool, forKey key: KeyRawValue) {
        storage[key.description] = value
    }
}
