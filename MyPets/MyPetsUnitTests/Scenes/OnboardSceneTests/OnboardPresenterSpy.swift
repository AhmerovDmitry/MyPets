//
//  OnboardPresenterSpy.swift
//  MyPetsUnitTests
//
//  Created by Dmitriy Akhmerov on 16.04.2022.
//  Copyright (c) 2022 Dmitriy Akhmerov. All rights reserved.
//

import Foundation
@testable import MyPets

final class OnboardPresenterSpy: OnboardPresenterProtocol {

	var model = OnboardModel()

	func prepareData(from model: OnboardModel) {
		self.model = model
	}
}
