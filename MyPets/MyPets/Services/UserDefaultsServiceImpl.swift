//
//  UserDefaultsService.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 14.04.2021.
//

import UIKit

protocol UDRepository {
    func bool(forKey defaultName: String) -> Bool
    func setValue(_ value: Any?, forKey key: String)
}

extension UserDefaults: UDRepository {}

protocol KeyDescription {
    var description: String { get }
}

typealias KeyRawValue = UserDefaultsServiceImpl.KeyRawValue

protocol UserDefaultsService: AnyObject {
    func value(forKey key: KeyRawValue) -> Bool
    func setValue(_ value: Bool, forKey key: KeyRawValue)
}

final class UserDefaultsServiceImpl: UserDefaultsService {
    enum KeyRawValue: KeyDescription {
        case isNotFirstLaunch, isAppPurchased

        var description: String {
            switch self {
            case .isNotFirstLaunch:
                return "isNotFirstLaunch"
            case .isAppPurchased:
                return "isAppPurchased"
            }
        }
    }

    private let repository: UDRepository

    init(repository: UDRepository) {
        self.repository = repository
    }

    func value(forKey key: KeyRawValue) -> Bool {
        return repository.bool(forKey: key.description)
    }
    func setValue(_ value: Bool, forKey key: KeyRawValue) {
        repository.setValue(value, forKey: key.description)
    }
}
