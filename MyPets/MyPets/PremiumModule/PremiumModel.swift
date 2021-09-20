//
//  PremiumModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 08.08.2021.
//

import Foundation

protocol PremiumModelProtocol {
    var description: [String] { get }
}

struct PremiumModel: PremiumModelProtocol {
    let description = [
        "Неограниченное количество питомцев",
        "Календарь прививок, лечение и профилактика болезней (В разработке)",
        "Заболевания, назначения врача (В разработке)",
        "Все документы питомца в одном месте (В разработке)",
        "Рекомендации по уходу и питанию (В разработке)"
    ]
}
