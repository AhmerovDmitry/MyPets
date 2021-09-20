//
//  OnboardingPage.swift
//  MyPetsUITests
//
//  Created by Дмитрий Ахмеров on 19.09.2021.
//

import UIKit
import XCTest

class OnboardingPage: Page {
    var app: XCUIApplication

    var doneButton: XCUIElement {
        app.buttons.element(matching: .button, identifier: "doneButton")
    }

    required init(app: XCUIApplication) {
        self.app = app
    }

    func testFirstTapOnDoneButtonButton() -> Self {
        let text = app.staticTexts["Следите за погодными условиями прямо в приложении"]
        XCTAssertTrue(text.waitForExistence(timeout: 5))
        app.buttons["doneButton"].tap()
        return self
    }
    func testSecondTapOnDoneButtonButton() -> Self {
        let text = app.staticTexts["Вся информация о питомце всегда под рукой"]
        XCTAssertTrue(text.waitForExistence(timeout: 5))
        app.buttons["doneButton"].tap()
        return self
    }
    func testThirdTapOnDoneButtonButton() -> Self {
        let text = app.staticTexts["Выбирайте, куда сходить с любимым питомцем"]
        XCTAssertTrue(text.waitForExistence(timeout: 5))
        app.buttons["doneButton"].tap()
        return self
    }
    func testFourTapOnDoneButtonButton() -> TabBarPage {
        let text = app.staticTexts["Получите Premium для снятия ограничений"]
        XCTAssertTrue(text.waitForExistence(timeout: 5))
        app.buttons["doneButton"].tap()
        return TabBarPage(app: app)
    }
}
