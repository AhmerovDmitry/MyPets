//
//  UserDefaultsService.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 14.04.2021.
//

import UIKit

protocol KeyDescriptionProtocol {
    var description: String { get }
}

enum KeyRawValue: KeyDescriptionProtocol {
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

protocol UserDefaultsServiceProtocol {
    func value(forKey key: KeyRawValue) -> Bool
    func setValue(_ value: Bool, forKey key: KeyRawValue)
}

final class UserDefaultsService: UserDefaultsServiceProtocol {

    func value(forKey key: KeyRawValue) -> Bool {
        return UserDefaults.standard.bool(forKey: key.description)
    }
    func setValue(_ value: Bool, forKey key: KeyRawValue) {
        UserDefaults.standard.setValue(value, forKey: key.description)
    }
}
