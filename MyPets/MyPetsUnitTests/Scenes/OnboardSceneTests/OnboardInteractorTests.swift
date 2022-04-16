//
//  OnboardInteractorTests.swift
//  MyPetsUnitTests
//
//  Created by Dmitriy Akhmerov on 16.04.2022.
//  Copyright (c) 2022 Dmitriy Akhmerov. All rights reserved.//

import Foundation
import XCTest
@testable import MyPets

final class OnboardInteractorTests: XCTestCase {

	private var presenter: OnboardPresenterSpy!
	private var sut: OnboardInteractorProtocol!

	override func setUp() {
		super.setUp()
		presenter = OnboardPresenterSpy()
		sut = OnboardInteractor(presenter: presenter)
	}

	override func tearDown() {
		presenter = nil
		sut = nil
		super.tearDown()
	}

	func testInteractorFetchingValidModel() {
		// arrange
		let model = OnboardModel()

		// act
		sut.fetchData()

		// assert
		XCTAssertEqual(model.imageNameList.count, presenter.model.imageNameList.count)
		XCTAssertEqual(model.descriptionList.count, presenter.model.descriptionList.count)
	}

	func testInteractorFetchingValidImagesName() {
		// arrange
		let model = OnboardModel()

		// act
		sut.fetchData()

		// assert
		XCTAssertEqual(model.imageNameList.count, 4)
		XCTAssertEqual(model.imageNameList[0], presenter.model.imageNameList[0])
		XCTAssertEqual(model.imageNameList[1], presenter.model.imageNameList[1])
		XCTAssertEqual(model.imageNameList[2], presenter.model.imageNameList[2])
		XCTAssertEqual(model.imageNameList[3], presenter.model.imageNameList[3])
	}

	func testInteractorFetchingValidDescriptions() {
		// arrange
		let model = OnboardModel()

		// act
		sut.fetchData()

		// assert
		XCTAssertEqual(model.descriptionList.count, 4)
		XCTAssertEqual(model.descriptionList[0], presenter.model.descriptionList[0])
		XCTAssertEqual(model.descriptionList[1], presenter.model.descriptionList[1])
		XCTAssertEqual(model.descriptionList[2], presenter.model.descriptionList[2])
		XCTAssertEqual(model.descriptionList[3], presenter.model.descriptionList[3])
	}
}
