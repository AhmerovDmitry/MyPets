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
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            }
        }).resume()
    }
}
