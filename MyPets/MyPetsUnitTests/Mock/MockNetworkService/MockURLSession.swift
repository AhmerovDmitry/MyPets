//
//  MockURLSession.swift
//  MyPetsUnitTests
//
//  Created by Дмитрий Ахмеров on 20.09.2021.
//

import Foundation

class MockURLSession: Networking {
    var networkDataTaskDoubleToReturn: NetworkDataTask?

    var completion: (Data?, URLResponse?, Error?)?

    func performDataTask(with request: URLRequest,
                         completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkDataTask {
        if let completion = completion {
            completionHandler(completion.0, completion.1, completion.2)
        }
        return networkDataTaskDoubleToReturn ?? NetworkDataTaskSpy()
    }
}

class NetworkDataTaskSpy: NetworkDataTask {
    var resumeCounter = 0
    var cancelCounter = 0

    func resume() {
        resumeCounter += 1
    }
    func cancel() {
        cancelCounter += 1
    }
}
