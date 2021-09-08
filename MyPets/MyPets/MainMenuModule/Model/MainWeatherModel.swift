//
//  MainWeatherModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 02.09.2021.
//

import UIKit

struct MainWeatherModel {
    /// Поля для погодного API
    private let urlSite = "https://api.openweathermap.org/data/2.5/weather?"
    private let userLat = "lat=58.025995"
    private let userLon = "lon=38.928622"
    private let userConfig = "units=metric"
    private let urlKey = "appid=10dff189d22023f2127fd521780e2b2d"
    public var weatherURL: URL? {
        guard let url = URL(string: "\(urlSite)\(userLat)&\(userLon)&\(userConfig)&\(urlKey)") else { return nil }
        return url
    }

    /// Поля для собственногог API
    public let httpAdditionalHeaders = ["secret-key": "$2b$10$Fk4etsK4fRpWVHR/RDgUOurwV7bW10aCC2rT4M13xO6CgnY4Bphbi"]
    public let imagesURL = URL(string: "https://api.jsonbin.io/b/6127b582076a223676b18d03/6")
}
