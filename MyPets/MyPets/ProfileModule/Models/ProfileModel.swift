//
//  ProfileModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.09.2021.
//

import UIKit

protocol ProfileModelProtocol {
    var controllerTitle: String { get }
    var profileTableViewSectionBody: [[String]] { get }
    var profileTableViewSectionImages: [UIImage?] { get }
}

final class ProfileModel: ProfileModelProtocol {
    let controllerTitle = "Профиль"
    let profileTableViewSectionBody = [
        ["Питомцы"],
        ["MyPets Premium"],
        ["Связаться с разработчиком", "О приложении"],
        ["Для разработчиков"]
    ]
    let profileTableViewSectionImages = [
        UIImage(systemName: "archivebox")?.withRenderingMode(.alwaysTemplate),
        UIImage(named: "crownIcon"),
        UIImage(systemName: "message")?.withRenderingMode(.alwaysTemplate),
        UIImage(systemName: "keyboard")?.withRenderingMode(.alwaysTemplate)
    ]
}
