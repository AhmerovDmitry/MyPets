//
//  NetworkServiceTests.swift
//  MyPetsUnitTests
//
//  Created by Дмитрий Ахмеров on 19.09.2021.
//

import XCTest

class NetworkServiceTests: XCTestCase {

    private var sut: NetworkServiceProtocol!
    private var session: MockURLSession!

    override func setUpWithError() throws {
        try super.setUpWithError()
        session = MockURLSession()
        sut = NetworkService(session: session)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testExample() {
        // arrange
        let test1 = "Что-то пошло не так и вы получили сетевую ошибку!"
        let test2 = "Что-то пошло не так и данные пришли в неверном формате!"
        let test3 = "Что-то пошло не так и мы даже не знаем, что именно!"

        // act
        let result1 = NetworkServiceError.network.message
        let result2 = NetworkServiceError.decodable.message
        let result3 = NetworkServiceError.unknown.message

        // assert
        XCTAssertEqual(result1, test1)
        XCTAssertEqual(result2, test2)
        XCTAssertEqual(result3, test3)
    }

    func testValueIsLoadingCanceledChangedAfterCallMethodCancelNetworkRequest() {
        // arrange
        let value = sut.isLoadingCanceled

        // act
        sut.cancelNetworkRequest()

        // assert
        XCTAssertEqual(value, false)
    }

    func testServiceResumeDataTask() {
        // arrange
        let spy = NetworkDataTaskSpy()
        session.networkDataTaskDoubleToReturn = spy

        // act
        let url = URL(string: "https://google.com")
        sut.loadJSONData(from: url, decodeModel: WeatherDescription.self, completion: { _ in })

        // assert
        XCTAssertEqual(spy.resumeCounter, 1)
    }

    func testServiceCancelDataTask() {
        // arrange
        let spy = NetworkDataTaskSpy()
        session.networkDataTaskDoubleToReturn = spy

        // act
        let url = URL(string: "https://google.com")
        sut.loadJSONData(from: url, decodeModel: WeatherDescription.self, completion: { _ in })
        sut.cancelNetworkRequest()

        // assert
        XCTAssertEqual(spy.cancelCounter, 1)
    }

    func testResultErrorEqualFailureCaseInCompletion() {
        // arrange
        var resultError: NetworkServiceError?
        let value: (Data?, URLResponse?, Error?) = (nil, nil, nil)
        session.completion = value
        let url = URL(string: "https://google.com")

        // act
        sut.loadJSONData(from: url, decodeModel: WeatherDescription.self) { result in
            switch result {
            case .success(let data): XCTFail("Должны прийти nil - \(data)")
            case .failure(let error): resultError = error
            }
        }

        // assert
        XCTAssertEqual(resultError, .network)
    }

    func testResultDataNotEqualNilWithValidResponse() {
        // arrange
        let url = URL(string: "https://google.com")!

        var resultData: WeatherDescription?

        let test = WeatherDescription(weather: [.init(main: "", description: "")], main: .init(temp: 1.1), name: "")
        let data = try? JSONEncoder().encode(test)

        let httpResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)

        let value: (Data?, URLResponse?, Error?) = (data, httpResponse, nil)
        session.completion = value

        // act
        sut.loadJSONData(from: url, decodeModel: WeatherDescription.self) { result in
            switch result {
            case .success(let data):
                resultData = data
            case .failure(let error): XCTFail("Должны прийти данные - \(error)")
            }
        }

        // assert
        XCTAssertNotNil(resultData)
    }

    func testResultErrorEqualDEcodableErrorElseDEcodeModelNotEqualTestModel() {
        // arrange
        let url = URL(string: "https://google.com")!

        var resultError: NetworkServiceError?

        let test = WeatherDescription(weather: [.init(main: "", description: "")], main: .init(temp: 1.1), name: "")
        let data = try? JSONEncoder().encode(test)

        let httpResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)

        let value: (Data?, URLResponse?, Error?) = (data, httpResponse, nil)
        session.completion = value

        // act
        sut.loadJSONData(from: url, decodeModel: WeatherImages.self) { result in
            switch result {
            case .success(let error): XCTFail("Должны прийти ошибка декодирования - \(error)")
            case .failure(let error): resultError = error
            }
        }

        // assert
        XCTAssertEqual(resultError, .decodable)
    }

    func testSessionBuildWithoutHttpHeaders() {
        sut = NetworkService(httpAdditionalHeaders: nil)

        XCTAssertNotNil(sut)
    }

    func testReturnNilElseURLStringNotValid() {
        // arrange
        let url = ""

        // act
        let result = sut.downloadImage(at: url)

        // assert
        XCTAssertNil(result)
    }

    func testReturnNilElseURLStringValid() {
        // arrange
        let url = "Bar"

        // act
        let result = sut.downloadImage(at: url)

        // assert
        XCTAssertNil(result)
    }

    func testStringPathContentsNotNil() {
        // arrange
        let imageURL = Bundle(for: NetworkServiceTests.self).url(forResource: "userImage",
                                                                 withExtension: "jpeg")!.absoluteString

        // act
        let result = sut.downloadImage(at: imageURL)

        // assert
        XCTAssertNotNil(result)
    }
}
