//
//  ProfileViewControllerDelegate.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 04.01.2021.
//

import UIKit

protocol ProfileViewControllerDelegate: AnyObject {
    func updateUser(profile: UserProfileModel)
}
