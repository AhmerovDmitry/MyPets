//
//  LocationModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 14.09.2021.
//

import Foundation

protocol LocationValueProtocol {
    var placemarkTitle: [String] { get }
    var placemarkRequest: [String] { get }
    func tappedRequestButtonWithID(_ id: Int)
}

final class LocationModel: LocationValueProtocol {
    var placemarkTitle: [String] = ["Зоомагазины",
                                    "Клиники",
                                    "Парки",
                                    "Кафе и рестораны",
                                    "Площадки для собак",
                                    "Отели для животных",
                                    "Приюты"]
    var placemarkRequest: [String] = ["зоомагазин",
                                      "ветеринар",
                                      "парк",
                                      "кафе",
                                      "площадка для собак",
                                      "гостиница для животных",
                                      "приют для животных"]
    func tappedRequestButtonWithID(_ id: Int) {
        print(id)
    }
}
