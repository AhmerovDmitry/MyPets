//
//  MockUDRepository.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 17.09.2021.
//

import Foundation

class MockUDRepository: UDRepository {
    var repository: [String: Any] = [:]

    func bool(forKey defaultName: String) -> Bool {
        guard let value = repository[defaultName] as? Bool else { return false }
        return value
    }

    func setValue(_ value: Any?, forKey key: String) {
        repository[key] = value
    }
}
