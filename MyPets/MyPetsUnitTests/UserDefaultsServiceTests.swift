//
//  UserDefaultsServiceTests.swift
//  MyPetsUnitTests
//
//  Created by Дмитрий Ахмеров on 17.09.2021.
//

import XCTest

class UserDefaultsServiceTests: XCTestCase {

    private var sut: UserDefaultsService!
    private var repositoryMock: MockUDRepository!

    override func setUpWithError() throws {
        try super.setUpWithError()
        repositoryMock = MockUDRepository()
        sut = UserDefaultsServiceImpl(repository: repositoryMock)
    }

    override func tearDownWithError() throws {
        repositoryMock = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testValueIsTrueIfValueForKeyIsAppPurchasedIsSet() throws {
        // act
        sut.setValue(true, forKey: .isAppPurchased)
        // assert
        let result = try XCTUnwrap(repositoryMock.repository["isAppPurchased"] as? Bool)
        XCTAssertTrue(result)
    }

    func testValueIsFalseIfValueForKeyIsAppPurchasedIsSet() throws {
        // act
        sut.setValue(false, forKey: .isAppPurchased)
        // assert
        let result = try XCTUnwrap(repositoryMock.repository["isAppPurchased"] as? Bool)
        XCTAssertFalse(result)
    }

    func testValueIsTrueIfValueForKeyIsAppPurchasedAsTrue() throws {
        // arrange
        repositoryMock.repository["isAppPurchased"] = true
        // act
        let result = sut.value(forKey: .isAppPurchased)
        // assert
        XCTAssertTrue(result)
    }

    func testValueIsFalseIfValueForKeyIsAppPurchasedAsTrue() throws {
        // arrange
        repositoryMock.repository["isAppPurchased"] = false
        // act
        let result = sut.value(forKey: .isAppPurchased)
        // assert
        XCTAssertFalse(result)
    }

    func testValueIsFalseIfValueForKeyIsAppPurchasedDoesNotExist() throws {
        // arrange
        repositoryMock.repository["isAppPurchased"] = nil
        // act
        let result = sut.value(forKey: .isAppPurchased)
        // assert
        XCTAssertFalse(result)
    }

    func testValueIsTrueIfValueForKeyIsNotFirstLaunchIsSet() throws {
        // act
        sut.setValue(true, forKey: .isNotFirstLaunch)
        // assert
        let result = try XCTUnwrap(repositoryMock.repository["isNotFirstLaunch"] as? Bool)
        XCTAssertTrue(result)
    }

    func testValueIsFalseIfValueForKeyIsNotFirstLaunchIsSet() throws {
        // act
        sut.setValue(false, forKey: .isNotFirstLaunch)
        // assert
        let result = try XCTUnwrap(repositoryMock.repository["isNotFirstLaunch"] as? Bool)
        XCTAssertFalse(result)
    }

    func testValueIsTrueIfValueForKeyIsNotFirstLaunchAsTrue() throws {
        // arrange
        repositoryMock.repository["isNotFirstLaunch"] = true
        // act
        let result = sut.value(forKey: .isNotFirstLaunch)
        // assert
        XCTAssertTrue(result)
    }

    func testValueIsFalseIfValueForKeyIsNotFirstLaunchAsTrue() throws {
        // arrange
        repositoryMock.repository["isNotFirstLaunch"] = false
        // act
        let result = sut.value(forKey: .isNotFirstLaunch)
        // assert
        XCTAssertFalse(result)
    }

    func testValueIsFalseIfValueForKeyIsNotFirstLaunchDoesNotExist() throws {
        // arrange
        repositoryMock.repository["isNotFirstLaunch"] = nil
        // act
        let result = sut.value(forKey: .isNotFirstLaunch)
        // assert
        XCTAssertFalse(result)
    }
}
