//
//  UserDefaultsServiceTests.swift
//  MyPetsUnitTests
//
//  Created by Дмитрий Ахмеров on 17.09.2021.
//

import XCTest
@testable import MyPets

class UserDefaultsServiceTests: XCTestCase {

    private var userDefaultsService: UserDefaultsServiceProtocol!

    override func setUp() {
        super.setUp()
        userDefaultsService = UserDefaultsService()
    }

    func testThatValueAppPurchasedEqualTrue() {
        // arrange
        userDefaultsService.setValue(true, forKey: .isAppPurchased)
        // act
        let result = userDefaultsService.value(forKey: .isAppPurchased)
        // assert
        XCTAssertTrue(result)
    }

    func testThatValueAppPurchasedEqualFalse() {
        // arrange
        userDefaultsService.setValue(false, forKey: .isAppPurchased)
        // act
        let result = userDefaultsService.value(forKey: .isAppPurchased)
        // assert
        XCTAssertFalse(result)
    }

    func testThatValueNotFirstLaunchEqualTrue() {
        // arrange
        userDefaultsService.setValue(true, forKey: .isNotFirstLaunch)
        // act
        let result = userDefaultsService.value(forKey: .isNotFirstLaunch)
        // assert
        XCTAssertTrue(result)
    }

    func testThatValueNotFirstLaunchEqualFalse() {
        // arrange
        userDefaultsService.setValue(false, forKey: .isNotFirstLaunch)
        // act
        let result = userDefaultsService.value(forKey: .isNotFirstLaunch)
        // assert
        XCTAssertFalse(result)
    }

}
