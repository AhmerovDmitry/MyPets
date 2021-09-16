//
//  NetworkService.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.09.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func loadJSONData<T: Codable>(from url: URL?,
                                  httpAdditionalHeaders: [AnyHashable: Any]?,
                                  decodeModel: T.Type,
                                  completion: @escaping(Result<T, NetworkServiceError>) -> Void)
    func cancelNetworkRequest()
}

final class NetworkService {
    private let decoder = JSONDecoder()
    private var session = URLSession.shared
    private var sessionDataTask: URLSessionDataTask?
}

extension NetworkService: NetworkServiceProtocol {
    /// Метод запроса данных из сети
    /// - Parameters:
    ///   - url: URL запроса
    ///   - httpAdditionalHeaders: Хеддер, если он отсутствует, то будет выполнена дефолтная реализация
    ///   - decodeModel: Дженерик модель в которую будут декодированы данные
    ///   - completion: Комплишн хендлер выполнения
    func loadJSONData<T: Codable>(from url: URL?,
                                  httpAdditionalHeaders: [AnyHashable: Any]?,
                                  decodeModel: T.Type,
                                  completion: @escaping (Result<T, NetworkServiceError>) -> Void) {

        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = httpAdditionalHeaders
        configuration.urlCache = URLCache(memoryCapacity: 5 * 1_000_000,
                                          diskCapacity: 5 * 1_000_000,
                                          diskPath: "weatherCache")
        session = URLSession(configuration: configuration)
        guard let url = url else { return }

        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        request.timeoutInterval = 60

        sessionDataTask = session.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            guard let self = self else { return }
            do {
                let response = try self.httpResponse(data: data, response: response)
                guard let data = self.decodeJson(type: decodeModel, from: response) else {
                    completion(.failure(.decodable))
                    return
                }
                completion(.success(data))
            } catch {
                completion(.failure(.network))
            }
        })
        sessionDataTask?.resume()
    }

    func cancelNetworkRequest() {
        if let task = sessionDataTask {
            task.cancel()
        }
    }

    private func httpResponse(data: Data?, response: URLResponse?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode),
              let data = data else {
            throw NetworkServiceError.network
        }
        return data
    }

    private func decodeJson<T: Decodable>(type: T.Type, from: Data?) -> T? {
        guard let data = from else { return nil }
        do {
            let result = try decoder.decode(type.self, from: data)
            return result
        } catch {
            debugPrint(NetworkServiceError.decodable)
        }
        return nil
    }
}
