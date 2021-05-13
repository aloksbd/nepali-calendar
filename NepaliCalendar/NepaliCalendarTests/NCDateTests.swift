//
//  NCDateTests.swift
//  NepaliCalendarTests
//
//  Created by alok subedi on 12/05/2021.
//

import XCTest
import NepaliCalendar

class NCDateTests: XCTestCase {
 
    func test_initFromDate_returnsEquivalentNCDate() {
        let date = Date(timeIntervalSince1970: TimeInterval(1620832329))
        let sut = NCDate(from: date, timeZone: TimeZone(identifier: "Asia/Kathmandu")!)
        let expectedNCDate = NCDate(day: 12, month: 5, year: 2021)
        
        XCTAssertEqual(sut, expectedNCDate)
    }
    
    func test_convertNCDateToDate_throwsInvalidDateOnInvalidNCDate() {
        let invalidNCDates = [
            NCDate(day: 23, month: 32, year: 2020),
            NCDate(day: 90, month: 12, year: 2020),
            NCDate(day: 12, month: 32, year: 2020),
            NCDate(day: 12, month: 12, year: 50000)
        ]
        
        try? invalidNCDates.forEach { XCTAssertThrowsError(try $0.date()) }
    }

}
