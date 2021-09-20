//
//  PetMenuModelTests.swift
//  MyPetsUnitTests
//
//  Created by Дмитрий Ахмеров on 20.09.2021.
//

import XCTest

class PetMenuModelTests: XCTestCase {

    var sut: PetMenuProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = PetMenuModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testDefaultValueEqualSetDefaultValue() {
        // arrange
        let defaultName = "Кличка не указана"
        let defaultBreed = "Порода не указана"
        let defaultBirthday = "00.00.00"

        // assert
        XCTAssertEqual(sut.defaultName, defaultName)
        XCTAssertEqual(sut.defaultBreed, defaultBreed)
        XCTAssertEqual(sut.defaultBirthday, defaultBirthday)
    }

}
