//
//  MainWeatherModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 02.09.2021.
//

import UIKit

final class MainWeatherModel {
    static let shared = MainWeatherModel()
    private init() {}
    // MARK: - Properties
    /// Погодный API
    private let urlSite = "https://api.openweathermap.org/data/2.5/weather?"
    private let userLat = "lat=58.025995"
    private let userLon = "lon=38.928622"
    private let userConfig = "units=metric"
    private let urlKey = "appid=10dff189d22023f2127fd521780e2b2d"
    public var weatherURL: URL? {
        guard let url = URL(string: "\(urlSite)\(userLat)&\(userLon)&\(userConfig)&\(urlKey)") else { return nil }
        return url
    }
    /// Хедер с секретным ключем для доступа к своему JSON файлу с ссылками на картинки
    public var configuration: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["secret-key": "$2b$10$Fk4etsK4fRpWVHR/RDgUOurwV7bW10aCC2rT4M13xO6CgnY4Bphbi"]
        return config
    }
    public let imagesURL = URL(string: "https://api.jsonbin.io/b/6127b582076a223676b18d03/6")
    public var weatherImages: [UIImage] = []
}
