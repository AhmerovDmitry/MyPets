//
//  NetwokingManager.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 26.08.2021.
//

import UIKit

final class NetworkingManager {
    static let shared = NetworkingManager()
    private init() {}
    public func loadJSONData(from url: URL,
                             configuration: URLSessionConfiguration,
                             completion: @escaping(Result<Data, Error>) -> Void) {
        let session = URLSession(configuration: configuration)
        session.dataTask(with: url, completionHandler: { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }).resume()
    }
}

/*
let config = URLSessionConfiguration.default
config.httpAdditionalHeaders = [
    "secret-key": "$2b$10$Fk4etsK4fRpWVHR/RDgUOurwV7bW10aCC2rT4M13xO6CgnY4Bphbi"
]
let session = URLSession(configuration: config)
let stringUrl = URL(string: "https://api.jsonbin.io/b/6127b582076a223676b18d03/1")
session.dataTask(with: stringUrl!, completionHandler: { data, _, error in
    if let error = error {
        let alert = UIAlertController(title: "Упс, что-то пошло не по плану!",
                                      message: "Проверьте интернет соединение на своём устройстве, информация попробует обновиться сама через некоторое время",
                                      preferredStyle: .alert)

    }
    if let data = data {
        print(String(data: data, encoding: .utf8))
    }
}).resume()
*/
