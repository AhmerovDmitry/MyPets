//
//  UserDefaultsService.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 14.04.2021.
//

import UIKit

/*
protocol UserDefaultsServiceProtocol {
    func isFirstLaunch() -> Bool
    func isAppNotPurchased() -> Bool

    func setStandardKey(_ key: String)
}

final class UserDefaultsService: UserDefaultsServiceProtocol {

    /// Метод проверяющий первый запуск приложения
    /// - Returns: Возвращаемое булевое значение
    func isFirstLaunch() -> Bool {
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: "isFirstLaunch")
        if isFirstLaunch {
            setStandardKey("isFirstLaunch")
//            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }

    func setStandardKey(_ key: String) {
        UserDefaults.standard.set(true, forKey: key)
    }

    /// Метод проверяющий статус покупки приложения
    /// - Returns: Возвращаемое булевое значение
    func isAppNotPurchased() -> Bool {
        let paidStatus = !UserDefaults.standard.bool(forKey: "paidStatus")
        if paidStatus {
            setStandardKey("paidStatus")
//            UserDefaults.standard.synchronize()
        }
        return paidStatus
    }
}
*/

enum RawValueType: String {
    case isFirstLaunch = "isNotFirstLaunch"
    case isAppPurchased = "isAppPurchased"
}

protocol UserDefaultsServiceProtocol {
    func value(forKey key: String) -> Bool
    func setValue(_ value: Bool, forKey key: String)
}

final class UserDefaultsService: UserDefaultsServiceProtocol {
    func value(forKey key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    func setValue(_ value: Bool, forKey key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
}
