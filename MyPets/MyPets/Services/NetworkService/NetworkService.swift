//
//  NetworkService.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.09.2021.
//

import UIKit

protocol NetworkServiceProtocol {
    var isLoadingCanceled: Bool { get }

    func loadJSONData<T: Codable>(from url: URL?, decodeModel: T.Type,
                                  completion: @escaping(Result<T, NetworkServiceError>) -> Void)
    func cancelNetworkRequest()
    func downloadImage(at url: String) -> UIImage?
}

protocol Networking {
    func performDataTask(with request: URLRequest,
                         completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkDataTask
}
extension URLSession: Networking {
    func performDataTask(with request: URLRequest,
                         completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkDataTask {
        return dataTask(with: request, completionHandler: completionHandler)
    }
}
protocol NetworkDataTask {
    func resume()
    func cancel()
}
extension URLSessionDataTask: NetworkDataTask {}

final class NetworkService {
    private let decoder = JSONDecoder()
    private var session: Networking
    private var sessionDataTask: NetworkDataTask?

    var isLoadingCanceled = false

    init(session: Networking) {
        self.session = session
    }

    convenience init(httpAdditionalHeaders: [AnyHashable: Any]?) {

        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = httpAdditionalHeaders
        configuration.urlCache = URLCache(memoryCapacity: 5 * 1_000_000,
                                          diskCapacity: 5 * 1_000_000,
                                          diskPath: "weatherCache")
        let session = URLSession(configuration: configuration)

        self.init(session: session)
    }
}

extension NetworkService: NetworkServiceProtocol {

    /// Метод запроса данных из сети
    /// - Parameters:
    ///   - url: URL запроса
    ///   - httpAdditionalHeaders: Хеддер, если он отсутствует, то будет выполнена дефолтная реализация
    ///   - decodeModel: Дженерик модель в которую будут декодированы данные
    ///   - completion: Комплишн хендлер выполнения
    func loadJSONData<T: Codable>(from url: URL?, decodeModel: T.Type,
                                  completion: @escaping (Result<T, NetworkServiceError>) -> Void) {

        guard let url = url else { return }

        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        request.timeoutInterval = 60

        sessionDataTask = session.performDataTask(with: request, completionHandler: { [weak self] data, response, _ in
            guard let self = self else { return }
            do {
                let data = try self.httpResponse(data: data, response: response)
                guard let response = self.decodeJson(type: decodeModel, from: data) else {
                    completion(.failure(.decodable))
                    return
                }
                completion(.success(response))
            } catch {
                if self.isLoadingCanceled {
                    self.isLoadingCanceled = false
                    return
                }
                completion(.failure(.network))
            }
        })
        sessionDataTask?.resume()
    }

    /// Метод загрузки изображения из сети
    /// - Parameter url: Строка с сылкой на изображение
    /// - Returns: Полученное изображение из сети
    func downloadImage(at url: String) -> UIImage? {
        guard let url = URL(string: url) else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        let image = UIImage(data: imageData)
        return image
    }

    /// Метод отменяющий запрос в сеть

    func cancelNetworkRequest() {
        isLoadingCanceled = true
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
            #if debug
            debugPrint(NetworkServiceError.decodable)
            #endif
        }
        return nil
    }
}
