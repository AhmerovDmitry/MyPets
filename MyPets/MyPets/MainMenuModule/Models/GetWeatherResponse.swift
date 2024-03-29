//
//  GetWeatherResponse.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.09.2021.
//

import Foundation

struct WeatherDescription: Codable {
    let weather: [WeatherDescription]
    let main: Temperature
    let name: String?

    struct Temperature: Codable {
        let temp: Double?
    }
    struct WeatherDescription: Codable {
        let main: String?
        let description: String?
    }
}

struct WeatherImages: Codable {
    let homeImages: [String]
    let strollImages: [String]
    let backgroundImage: String
}

/*
СПИСОК ПОГОДНЫХ ЯВЛЕНИЙ ДЛЯ ЗАГРУЗКИ КАРТИНОК
Thunderstorm - Гроза
Rain - Дождь
Snow - Снег
Mist - Туман
Smoke - Дым
Dust - Пыль
Fog - Туман
Sand - Песок
Dust - Пыль
Ash - Пепел
Squall - Шквал
Tornado - Торнадо
Clear - Чистое небо
Clouds - Облачно
Drizzle - Морось
Haze - Туман
*/
