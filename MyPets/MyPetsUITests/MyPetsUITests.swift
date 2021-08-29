//
//  MyPetsUITests.swift
//  MyPetsUITests
//
//  Created by Дмитрий Ахмеров on 27.08.2021.
//

import XCTest
@testable import MyPets

class MyPetsUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testCloseButtonWorkAndClosedScreen() {
//        button.accessibilityIdentifier = "skipButton" задается в настройках создания объекта
//        app.buttons["skipButton"].tap()
    }
}
