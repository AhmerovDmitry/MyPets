//
//  PremiumPresenterSpy.swift
//  MyPetsUnitTests
//
//  Created by Dmitriy Akhmerov on 17.04.2022.
//  Copyright (c) 2022 Dmitriy Akhmerov. All rights reserved.
//

import Foundation
@testable import MyPets

final class PremiumPresenterSpy: PremiumPresenterProtocol {
	
	var model = PremiumModel()

	func prepareData(from model: PremiumModel) {
		self.model = model
	}
}
