//
//  CurrentEventUnitTest.swift
//  ChromerivalsTests
//
//  Created by Ismael Bolaños García on 27/3/22.
//

import XCTest
@testable import Chromerivals

class CurrentEventUnitTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testServerDateToLocalDate() throws {
        let date = "2022-03-22T04:10:00+01:00"
        
        let serverDateStringToLocalDate = date.toLocalDate()
        let localDateToLocalString = Constants.dateFormaterToLocalTimeZone.string(for: serverDateStringToLocalDate)

        XCTAssertEqual(localDateToLocalString, "2022-03-22T03:10:00+0000")
    }
    
    func testEventEndTimeToTimerText() throws {
        let endTime = "2022-03-22T04:10:00+01:00"
        let nowDate = Constants.dateFormaterToLocalTimeZone.date(from: "2022-03-22T03:05:00+00:00")
        
        let serverDateStringToLocalDate = endTime.toLocalDate()
        let timerStringFromLocalDate = nowDate?.countDownString(until: serverDateStringToLocalDate)
        
        XCTAssertEqual(timerStringFromLocalDate, "05:00")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
