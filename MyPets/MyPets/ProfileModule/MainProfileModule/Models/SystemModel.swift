//
//  SystemModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.09.2021.
//

import Foundation

protocol SystemModelProtocol {
    var systemTitleContent: [String] { get }
}

final class SystemModel: SystemModelProtocol {
    let systemTitleContent = ["Reset_launch_status", "Reset_purchase"]
}
