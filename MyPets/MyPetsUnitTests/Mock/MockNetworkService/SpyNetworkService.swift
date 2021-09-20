//
//  SpyNetworkService.swift
//  MyPetsUnitTests
//
//  Created by Дмитрий Ахмеров on 20.09.2021.
//

import Foundation

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
