//
//  MainWeatherModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 02.09.2021.
//

import UIKit

struct MainWeatherModel {
    // API погоды
    private let urlSite = "https://api.openweathermap.org/data/2.5/weather?"
    private var userLat = ""
    private var userLon = ""
    private let userConfig = "units=metric"
    private let urlKey = "appid=10dff189d22023f2127fd521780e2b2d"
    var weatherURL: URL? {
        guard let url = URL(string: "\(urlSite)\(userLat)&\(userLon)&\(userConfig)&\(urlKey)") else { return nil }
        return url
    }

    // API картинок
    let httpAdditionalHeaders = ["secret-key": "$2b$10$Fk4etsK4fRpWVHR/RDgUOurwV7bW10aCC2rT4M13xO6CgnY4Bphbi"]
    let imagesURL = URL(string: "https://api.jsonbin.io/b/6127b582076a223676b18d03/6")

    mutating func setUserCoordinate(lat: String, lon: String) {
        userLat = "lat=" + lat
        userLon = "lon=" + lon
    }
}
