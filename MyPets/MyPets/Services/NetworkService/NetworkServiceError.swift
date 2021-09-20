//
//  NetworkServiceError.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.09.2021.
//

import Foundation

enum NetworkServiceError: Error {
    case network, decodable, unknown

    var message: String {
        switch self {
        case .network:
            return "Что-то пошло не так и вы получили сетевую ошибку!"
        case .decodable:
            return "Что-то пошло не так и данные пришли в неверном формате!"
        case .unknown:
            return "Что-то пошло не так и мы даже не знаем, что именно!"
        }
    }
}
