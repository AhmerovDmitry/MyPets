//
//  NetworkService.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 06.09.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func loadJSONData<T: Codable>(from url: URL, httpAdditionalHeaders: [AnyHashable: Any]?, decodeModel: T.Type,
                             completion: @escaping(Result<T, Error>) -> Void)
}

final class NetworkService {
    private let decoder = JSONDecoder()
    private var session = URLSession.shared
}

extension NetworkService: NetworkServiceProtocol {
    func loadJSONData<T: Codable>(from url: URL, httpAdditionalHeaders: [AnyHashable: Any]?, decodeModel: T.Type,
                         completion: @escaping (Result<T, Error>) -> Void) {

        if let header = httpAdditionalHeaders {
            let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = header
            session = URLSession(configuration: config)
        }

        session.dataTask(with: url, completionHandler: { [weak self] data, _, error in
            do {
                if let data = data {
                    if let data = try self?.decoder.decode(T.self, from: data) {
                        completion(.success(data))
                    }
                    if let error = error {
                        completion(.failure(error))
                    }
                }
            } catch {
                completion(.failure(error))
            }
        }).resume()
    }
}
