//
//  DateFormatterServiceTests.swift
//  MyPetsUnitTests
//
//  Created by Дмитрий Ахмеров on 18.09.2021.
//

import XCTest

class DateFormatterServiceTests: XCTestCase {

    var sut: DateFormatterService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DateFormatterServiceImpl()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testStringValueAfterFormattedEqualDate() {
        // arrange
        let value = "12.12.12"

        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        let date = formatter.date(from: value)

        // act
        let result = sut.stringToDate(value)

        // assert
        XCTAssertEqual(result, date)
    }

    func testEmptyValueAfterFormattedEqualNil() {
        // arrange
        let value = ""

        // act
        let result = sut.stringToDate(value)

        // assert
        XCTAssertNil(result)
    }

    func testDateValueAfterFormattedEqualString() {
        // arrange
        let value = "12.12.12"

        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        guard let date = formatter.date(from: value) else { return }

        // act
        let result = sut.dateToString(date)

        // assert
        XCTAssertEqual(result, value)
    }

    func testBrokenDateAfterFormattedDontEqualString() {
        // arrange
        let value = "12.12.1212"

        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        guard let date = formatter.date(from: value) else { return }

        // act
        let result = sut.dateToString(date)

        // assert
        XCTAssertNotEqual(result, value)
    }
}
