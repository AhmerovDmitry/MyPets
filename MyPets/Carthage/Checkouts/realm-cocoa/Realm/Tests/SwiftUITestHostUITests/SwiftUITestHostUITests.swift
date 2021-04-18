////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////


import XCTest
import RealmSwift
#if canImport(SwiftUI) && canImport(Combine) && swift(>=5.3.1)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
class SwiftUITests: XCTestCase {
    var realm: Realm!
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false

        // the realm must be created before app launch otherwise we will not have
        // write permissions
        let realmPath = URL(string: "\(FileManager.default.temporaryDirectory)\(UUID())")!
        let configuration = Realm.Configuration(fileURL: realmPath)
        self.realm = try! Realm(configuration: configuration)

        app.launchEnvironment = [
            "REALM_PATH": realmPath.absoluteString
        ]

        try realm.write {
            realm.deleteAll()
        }
    }

    override func tearDownWithError() throws {
        app.terminate()
        self.realm.invalidate()
        let config = realm.configuration
        self.realm = nil
        XCTAssert(try Realm.deleteFiles(for: config))
    }

    private func deleteString(for string: String) -> String {
        String(repeating: XCUIKeyboardKey.delete.rawValue, count: string.count)
    }

    func testSampleApp() throws {
        app.launch()
        // assert realm is empty
        XCTAssertEqual(realm.objects(ReminderList.self).count, 0)

        // add 3 lists, and assert that they have been added to
        // the UI and Realm
        let addButton = app.buttons["addList"]
        addButton.tap()
        addButton.tap()
        addButton.tap()
        XCTAssertEqual(realm.objects(ReminderList.self).count, 3)
        XCTAssertEqual(app.tables.firstMatch.cells.count, 3)

        // delete each person, operating from the zeroeth index
        for _ in 0..<app.tables.firstMatch.cells.count {
            let row = app.tables.firstMatch.cells.element(boundBy: 0)
            row.swipeLeft()
            app.buttons["Delete"].tap()
        }

        XCTAssertEqual(realm.objects(ReminderList.self).count, 0)
        XCTAssertEqual(app.tables.firstMatch.cells.count, 0)

        // add another list, and tap into the ReminderView
        addButton.tap()
        app.tables.firstMatch.cells.buttons.firstMatch.tap()
        app.buttons["addReminder"].tap()
        // type in a name
        app.tables.cells.firstMatch.buttons.firstMatch.tap()
        app.textFields["title"].tap()
        app.textFields["title"].typeText("My Reminder")
        // check to see if it is reflected live in the title view
        XCTAssert(app.navigationBars.staticTexts["My Reminder"].waitForExistence(timeout: 1.0))
        let myReminder = realm.objects(ReminderList.self).first!.reminders.first!
        XCTAssertEqual(myReminder.priority, .low)
        app.buttons["picker"].tap()
        app.buttons["medium"].tap()
        XCTAssertEqual(myReminder.priority, .medium)

        app.navigationBars.buttons.element(boundBy: 0).tap()

        // MARK: Test Move
        app.buttons["addReminder"].tap()
        XCTAssertEqual(realm.objects(ReminderList.self).first!.reminders.first!.title, "My Reminder")
        XCTAssertEqual(realm.objects(ReminderList.self).first!.reminders[1].title, "")

        app.buttons["Edit"].tap()
        app.buttons.matching(identifier: "Reorder").firstMatch.press(forDuration: 0.5, thenDragTo: app.tables.cells.element(boundBy: 1))

        XCTAssertEqual(realm.objects(ReminderList.self).first!.reminders.first!.title, "")
        XCTAssertEqual(realm.objects(ReminderList.self).first!.reminders[1].title, "My Reminder")

        // MARK: Test Delete
        // potentially brittle, but these are the hooks swiftUI gives us. when editing a list,
        // a cancel button appears on the left and a drag icon appears on the right. the label
        // for the cancel button is "Delete ", which when tapped, reveals the actual delete button
        // labeled "Delete"
        XCTAssertEqual(realm.objects(ReminderList.self).first!.reminders.count, 2)
        app.buttons.matching(identifier: "Delete ").firstMatch.tap()
        app.buttons.matching(identifier: "Delete").firstMatch.tap()
        XCTAssertEqual(realm.objects(ReminderList.self).first!.reminders.count, 1)
        app.buttons.matching(identifier: "Delete ").firstMatch.tap()
        app.buttons.matching(identifier: "Delete").firstMatch.tap()
        XCTAssertEqual(realm.objects(ReminderList.self).first!.reminders.count, 0)

        app.navigationBars.buttons.firstMatch.tap()
        app.tables.cells.firstMatch.swipeLeft()
        app.buttons.matching(identifier: "Delete").firstMatch.tap()
        XCTAssertEqual(realm.objects(ReminderList.self).count, 0)
    }

    func testMultipleEnvironmentRealms() {
        app.launchEnvironment["test_type"] = "multi_realm_test"
        app.launch()

        app.buttons["Realm A"].tap()
        XCTAssertEqual(app.staticTexts["test_text_view"].label, "realm_a")
        app.buttons["Back"].tap()

        app.buttons["Realm B"].tap()
        XCTAssertEqual(app.staticTexts["test_text_view"].label, "realm_b")
    }

    func testUnmanagedObjectState() {
        app.launchEnvironment["test_type"] = "unmanaged_object_test"
        app.launch()

        app.textFields["name"].tap()
        app.textFields["name"].typeText(deleteString(for: "New List"))
        app.textFields["name"].typeText("test name")
        app.navigationBars.firstMatch.tap()
        app.buttons["addReminder"].tap()
        XCTAssertEqual(realm.objects(ReminderList.self).first!.name, "test name")
    }
}
#endif
