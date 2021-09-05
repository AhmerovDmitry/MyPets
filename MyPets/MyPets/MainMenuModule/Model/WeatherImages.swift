//
//  WeatherImageModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 27.08.2021.
//

import Foundation

struct WeatherImages: Codable {
    let homeImages: [String]
    let strollImages: [String]
    let backgroundImage: String
}
