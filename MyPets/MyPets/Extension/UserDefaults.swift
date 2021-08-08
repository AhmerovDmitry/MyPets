//
//  UserDefaults.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 14.04.2021.
//

import UIKit

extension UserDefaults {
    /// Метод для отслеживания первого запуска
    static func isFirstLaunch() -> Bool {
        let isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch")
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
    /// Метод для отслеживания куплено ли приложение
    static func appPaidStatus() -> Bool {
        let paidStatus = UserDefaults.standard.bool(forKey: "paidStatus")
        if paidStatus {
            UserDefaults.standard.set(true, forKey: "paidStatus")
            UserDefaults.standard.synchronize()
        }
        return paidStatus
    }
}
