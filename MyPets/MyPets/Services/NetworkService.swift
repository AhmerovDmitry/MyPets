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
    private let session = URLSession.shared
}

extension NetworkService: NetworkServiceProtocol {
    func loadJSONData<T: Codable>(from url: URL, httpAdditionalHeaders: [AnyHashable: Any]?, decodeModel: T.Type,
                         completion: @escaping (Result<T, Error>) -> Void) {

        session.configuration.httpAdditionalHeaders = httpAdditionalHeaders

        session.dataTask(with: url, completionHandler: { [weak self] data, _, error in
            do {
                if let data = data {
                    if let data = try self?.decoder.decode(T.self, from: data) {
                        completion(.success(data))
                    }
                }
            } catch let error as NSError {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }).resume()
    }
}
