//
//  MainWeatherModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 02.09.2021.
//

import UIKit

struct MainWeatherModel {

    // API погоды

    private let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?"
    private let userConfig = "units=metric"
    private let urlKey = "appid=10dff189d22023f2127fd521780e2b2d"
    private var userLat = ""
    private var userLon = ""
    var weatherURL: URL? {
        guard let url = URL(string: "\(weatherUrl)\(userLat)&\(userLon)&\(userConfig)&\(urlKey)") else { return nil }
        return url
    }

    // Метод изменяет координаты для формирования запроса
    // Координаты берутся с геолокации пользователя

    mutating func setUserCoordinate(lat: String, lon: String) {
        userLat = "lat=" + lat
        userLon = "lon=" + lon
    }

    // API картинок
    
    let httpAdditionalHeaders = ["secret-key": "$2b$10$Fk4etsK4fRpWVHR/RDgUOurwV7bW10aCC2rT4M13xO6CgnY4Bphbi"]
    let imagesURL = URL(string: "https://api.jsonbin.io/b/6127b582076a223676b18d03/6")
}
