//
//  PremiumInteractorTests.swift
//  MyPetsUnitTests
//
//  Created by Dmitriy Akhmerov on 17.04.2022.
//  Copyright (c) 2022 Dmitriy Akhmerov. All rights reserved.//

import Foundation
import XCTest
@testable import MyPets

final class PremiumInteractorTests: XCTestCase {

	private var presenter: PremiumPresenterSpy!
	private var sut: PremiumInteractorProtocol!

	override func setUp() {
		super.setUp()
		presenter = PremiumPresenterSpy()
		sut = PremiumInteractor(presenter: presenter)
	}

	override func tearDown() {
		presenter = nil
		sut = nil
		super.tearDown()
	}

	func testInteractorFetchingValidModel() {
		// arrange
		let model = PremiumModel()

		// act
		sut.fetchData()

		// assert
		XCTAssertEqual(model.descriptionList.count, presenter.model.descriptionList.count)
	}

	func testInteractorFetchingValidDescriptions() {
		// arrange
		let model = PremiumModel()

		// act
		sut.fetchData()

		// assert
		XCTAssertEqual(model.descriptionList.count, 5)
		XCTAssertEqual(model.descriptionList[0], presenter.model.descriptionList[0])
		XCTAssertEqual(model.descriptionList[1], presenter.model.descriptionList[1])
		XCTAssertEqual(model.descriptionList[2], presenter.model.descriptionList[2])
		XCTAssertEqual(model.descriptionList[3], presenter.model.descriptionList[3])
	}
}
