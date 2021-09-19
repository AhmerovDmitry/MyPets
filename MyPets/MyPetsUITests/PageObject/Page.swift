//
//  Page.swift
//  MyPetsUITests
//
//  Created by Дмитрий Ахмеров on 19.09.2021.
//

import Foundation
import XCTest

protocol Page {
    var app: XCUIApplication { get }

    init(app: XCUIApplication)
}
