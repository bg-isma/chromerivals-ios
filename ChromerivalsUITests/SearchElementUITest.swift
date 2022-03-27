//
//  SearchElementUITest.swift
//  ChromerivalsUITests
//
//  Created by Ismael Bolaños García on 26/3/22.
//

import XCTest

class SearchElementUITest: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchPediaElement() throws {
        // splash
        sleep(3)
        
        // Home View
        app.tabBars.buttons["Search"].tap()
        
        // Search View
        let textField = app.textFields["Search..."]
        textField.tap()
        textField.typeText("vello")
        app.keyboards.buttons["Return"].tap()
        
        sleep(3)
        app.collectionViews.cells.element(boundBy: 3).tap()
    }

}
