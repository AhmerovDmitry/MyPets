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
		XCTAssertEqual(model.imagesName.count, presenter.model.imagesName.count)
		XCTAssertEqual(model.description.count, presenter.model.description.count)
	}

	func testInteractorFetchingValidImagesName() {
		// arrange
		let model = OnboardModel()

		// act
		sut.fetchData()

		// assert
		XCTAssertEqual(model.imagesName.count, 4)
		XCTAssertEqual(model.imagesName[0], "onboardImage_1")
		XCTAssertEqual(model.imagesName[1], "onboardImage_2")
		XCTAssertEqual(model.imagesName[2], "onboardImage_3")
		XCTAssertEqual(model.imagesName[3], "onboardImage_4")
	}

	func testInteractorFetchingValidDescriptions() {
		// arrange
		let model = OnboardModel()

		// act
		sut.fetchData()

		// assert
		XCTAssertEqual(model.description.count, 4)
		XCTAssertEqual(model.description[0], "Следите за погодными условиями прямо в приложении")
		XCTAssertEqual(model.description[1], "Вся информация о питомце всегда под рукой")
		XCTAssertEqual(model.description[2], "Выбирайте, куда сходить с любимым питомцем")
		XCTAssertEqual(model.description[3], "Получите Premium для снятия ограничений")
	}
}
