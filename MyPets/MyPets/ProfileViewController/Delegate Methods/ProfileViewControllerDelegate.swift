//
//  ProfileViewControllerDelegate.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 04.01.2021.
//

import UIKit

protocol ProfileViewControllerDelegate: class {
    func updateUser(image: UIImage?)
    func updateUser(profile: UserProfileModel)
}
