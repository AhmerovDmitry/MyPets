//
//  TabBarPage.swift
//  MyPetsUITests
//
//  Created by Дмитрий Ахмеров on 19.09.2021.
//

import Foundation
import XCTest

class TabBarPage: Page {
    var app: XCUIApplication

    required init(app: XCUIApplication) {
        self.app = app
    }

    func testTapProfileItem() -> Self {
        app.tabBars.buttons["Профиль"].tap()
        XCTAssertTrue(app.tabBars.buttons["Профиль"].isSelected)
        return self
    }
    func testTapPetItem() -> Self {
        app.tabBars.buttons["Питомцы"].tap()
        XCTAssertTrue(app.tabBars.buttons["Питомцы"].isSelected)
        return self
    }
    func testTapMainItem() {
        app.tabBars.buttons["Главная"].tap()
        XCTAssertTrue(app.tabBars.buttons["Главная"].isSelected)
    }
}
