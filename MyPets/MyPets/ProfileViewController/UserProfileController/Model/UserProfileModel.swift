//
//  UserProfileModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 02.01.2021.
//

import UIKit

struct UserProfileModel {
    var name: String? {
        get {
            return UserDefaults.standard.string(forKey: "name")
        } set {
            let defaults = UserDefaults.standard
            
            if let name = newValue {
                defaults.set(name, forKey: "name")
            } else {
                defaults.removeObject(forKey: "name")
            }
        }
    }
    var city: String? {
        get {
            return UserDefaults.standard.string(forKey: "city")
        } set {
            let defaults = UserDefaults.standard
            
            if let name = newValue {
                defaults.set(name, forKey: "city")
            } else {
                defaults.removeObject(forKey: "city")
            }
        }
    }
    var eMail: String? {
        get {
            return UserDefaults.standard.string(forKey: "eMail")
        } set {
            let defaults = UserDefaults.standard
            
            if let name = newValue {
                defaults.set(name, forKey: "eMail")
            } else {
                defaults.removeObject(forKey: "eMail")
            }
        }
    }
    var image: Data? {
        get {
            return UserDefaults.standard.data(forKey: "image")
            
        } set {
            let defaults = UserDefaults.standard
            
            if let name = newValue {
                defaults.set(name, forKey: "image")
            } else {
                defaults.removeObject(forKey: "image")
            }
        }
    }
}
