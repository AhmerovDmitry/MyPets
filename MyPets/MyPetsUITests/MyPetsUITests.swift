//
//  MyPetsUITests.swift
//  MyPetsUITests
//
//  Created by Дмитрий Ахмеров on 19.09.2021.
//

import XCTest
@testable import MyPets

class MyPetsUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launchArguments += ["-isNotFirstLaunch", "NO"]
        app.launchArguments += ["-isAppPurchased", "TRUE"]
        app.launch()
        addUIInterruptionMonitor(withDescription: "System Dialog") { alert -> Bool in
//            для устройств на английском языке использовать - alert.buttons["Allow Once"].tap()
            alert.buttons["Однократно"].tap()
            return true
        }
        app.tap()
    }
    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testExample() {
        OnboardingPage(app: app)
            .testFirstTapOnDoneButtonButton()
            .testSecondTapOnDoneButtonButton()
            .testThirdTapOnDoneButtonButton()
            .testFourTapOnDoneButtonButton()
            .testTapProfileItem()
            .testTapPetItem()
            .testTapMainItem()
    }
}
