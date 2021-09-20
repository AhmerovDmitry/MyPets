//
//  MainWeatherModelTests.swift
//  MyPetsUnitTests
//
//  Created by Дмитрий Ахмеров on 18.09.2021.
//

import XCTest

class MainWeatherModelTests: XCTestCase {

    private var sut: MainWeatherModel!

    override func setUpWithError() throws {
        sut = MainWeatherModelImpl()
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testUserValuesChangedValueInModel() {
        // arrange
        let url = sut.weatherURL

        // act
        sut.setUserCoordinate(lat: "Bar", lon: "Baz")

        // assert
        XCTAssertNotEqual(url, sut.weatherURL)
    }

    func testEmptyCoordinatesNotChangedValueInModel() {
        // arrange
        let url = sut.weatherURL

        // act
        sut.setUserCoordinate(lat: "", lon: "")

        // assert
        XCTAssertEqual(url, sut.weatherURL)
    }
}
