//
//  MyPetsSnapshotTests.swift
//  MyPetsSnapshotTests
//
//  Created by Дмитрий Ахмеров on 14.09.2021.
//

import SnapshotTesting
import XCTest
@testable import MyPets

class MyPetsSnapshotTests: XCTestCase {
    let storageService = StorageService()
    let userDefaultsService = UserDefaultsService()

    func testProfileController() throws {
        let sut = ProfileController(storageService: storageService, userDefaultsService: userDefaultsService)

        assertSnapshot(matching: sut, as: .image(on: .iPhoneSe))
    }

    func testPetMenuController() throws {
        let sut = PetMenuController(storageService: storageService, userDefaultsService: userDefaultsService)

        assertSnapshot(matching: sut, as: .image(on: .iPhoneSe))
    }
}
