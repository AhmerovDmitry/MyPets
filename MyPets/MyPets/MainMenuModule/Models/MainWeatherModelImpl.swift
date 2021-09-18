//
//  MainWeatherModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 02.09.2021.
//

import UIKit

protocol MainWeatherModel {
    var baseURL: String { get }
    var userConfig: String { get }
    var URLKey: String { get }
    var userLat: String { get }
    var userLon: String { get }
    var weatherURL: URL? { get }

    mutating func setUserCoordinate(lat: String, lon: String)
}

struct MainWeatherModelImpl: MainWeatherModel {

    // API погоды

    private(set) var baseURL = "https://api.openweathermap.org/data/2.5/weather?"
    private(set) var userConfig = "units=metric"
    private(set) var URLKey = "appid=10dff189d22023f2127fd521780e2b2d"
    private(set) var userLat = "lat="
    private(set) var userLon = "lon="
    var weatherURL: URL? {
        return URL(string: "\(baseURL)\(userLat)&\(userLon)&\(userConfig)&\(URLKey)")
    }

    // Метод изменяет координаты для формирования запроса
    // Координаты берутся с геолокации пользователя

    mutating func setUserCoordinate(lat: String, lon: String) {
        userLat += lat
        userLon += lon
    }

    // API картинок

    let httpAdditionalHeaders = ["secret-key": "$2b$10$Fk4etsK4fRpWVHR/RDgUOurwV7bW10aCC2rT4M13xO6CgnY4Bphbi"]
    let imagesURL = URL(string: "https://api.jsonbin.io/b/6127b582076a223676b18d03/6")
}
