//
//  OnboardModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 03.08.2021.
//

import Foundation

protocol OnboardModelProtocol {
    var imagesName: [String] { get }
    var description: [String] { get }
}

struct OnboardModel: OnboardModelProtocol {
    let imagesName = [
        "onboardImage_1",
        "onboardImage_2",
        "onboardImage_3",
        "onboardImage_4"
    ]
    let description = [
        "Следите за погодными условиями прямо в приложении",
        "Вся информация о питомце всегда под рукой",
        "Выбирайте, куда сходить с любимым питомцем",
        "Получите Premium для снятия ограничений"
    ]
}
