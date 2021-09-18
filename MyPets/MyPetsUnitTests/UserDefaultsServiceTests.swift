//
//  UserDefaultsServiceTests.swift
//  MyPetsUnitTests
//
//  Created by Дмитрий Ахмеров on 17.09.2021.
//

import XCTest
@testable import MyPets

class UserDefaultsServiceTests: XCTestCase {

    private var systemUnderTest: UserDefaultsService!
    private var repositoryMock: MockUDRepository!

    override func setUpWithError() throws {
        try super.setUpWithError()
        repositoryMock = MockUDRepository()
        systemUnderTest = UserDefaultsServiceImpl(repository: repositoryMock)
    }

    override func tearDownWithError() throws {
        repositoryMock = nil
        systemUnderTest = nil
        try super.tearDownWithError()
    }

    func testValueIsTrueIfValueForKeyIsAppPurchasedIsSet() throws {
        // act
        systemUnderTest.setValue(true, forKey: .isAppPurchased)
        // assert
        let result = try XCTUnwrap(repositoryMock.repository["isAppPurchased"] as? Bool)
        XCTAssertTrue(result)
    }

    func testValueIsFalseIfValueForKeyIsAppPurchasedIsSet() throws {
        // act
        systemUnderTest.setValue(false, forKey: .isAppPurchased)
        // assert
        let result = try XCTUnwrap(repositoryMock.repository["isAppPurchased"] as? Bool)
        XCTAssertFalse(result)
    }

    func testValueIsTrueIfValueForKeyIsAppPurchasedAsTrue() throws {
        // arrange
        repositoryMock.repository["isAppPurchased"] = true
        // act
        let result = systemUnderTest.value(forKey: .isAppPurchased)
        // assert
        XCTAssertTrue(result)
    }

    func testValueIsFalseIfValueForKeyIsAppPurchasedAsTrue() throws {
        // arrange
        repositoryMock.repository["isAppPurchased"] = false
        // act
        let result = systemUnderTest.value(forKey: .isAppPurchased)
        // assert
        XCTAssertFalse(result)
    }

    func testValueIsFalseIfValueForKeyIsAppPurchasedDoesNotExist() throws {
        // arrange
        repositoryMock.repository["isAppPurchased"] = nil
        // act
        let result = systemUnderTest.value(forKey: .isAppPurchased)
        // assert
        XCTAssertFalse(result)
    }

    func testValueIsTrueIfValueForKeyIsNotFirstLaunchIsSet() throws {
        // act
        systemUnderTest.setValue(true, forKey: .isNotFirstLaunch)
        // assert
        let result = try XCTUnwrap(repositoryMock.repository["isNotFirstLaunch"] as? Bool)
        XCTAssertTrue(result)
    }

    func testValueIsFalseIfValueForKeyIsNotFirstLaunchIsSet() throws {
        // act
        systemUnderTest.setValue(false, forKey: .isNotFirstLaunch)
        // assert
        let result = try XCTUnwrap(repositoryMock.repository["isNotFirstLaunch"] as? Bool)
        XCTAssertFalse(result)
    }

    func testValueIsTrueIfValueForKeyIsNotFirstLaunchAsTrue() throws {
        // arrange
        repositoryMock.repository["isNotFirstLaunch"] = true
        // act
        let result = systemUnderTest.value(forKey: .isNotFirstLaunch)
        // assert
        XCTAssertTrue(result)
    }

    func testValueIsFalseIfValueForKeyIsNotFirstLaunchAsTrue() throws {
        // arrange
        repositoryMock.repository["isNotFirstLaunch"] = false
        // act
        let result = systemUnderTest.value(forKey: .isNotFirstLaunch)
        // assert
        XCTAssertFalse(result)
    }

    func testValueIsFalseIfValueForKeyIsNotFirstLaunchDoesNotExist() throws {
        // arrange
        repositoryMock.repository["isNotFirstLaunch"] = nil
        // act
        let result = systemUnderTest.value(forKey: .isNotFirstLaunch)
        // assert
        XCTAssertFalse(result)
    }
}
