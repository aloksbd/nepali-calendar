//
//  DateConverterTests.swift
//  NepaliCalendarTests
//
//  Created by alok subedi on 01/05/2021.
//

import XCTest
import NepaliCalendar

class DateConverterTests: XCTestCase {
    
    func test_bSToAD_throwsErrorWhenDayOrMonthIsZero() {
        let month = 0
        let day = 0
        let sut = DateConverter()
        
        XCTAssertThrowsError(try sut.bSToAD(day: day, month: month, year: 0))
    }
    
    func test_bSToAd_throwsErrorWhenMonthIsGreaterThan12() {
        let month = 13
        let sut = DateConverter()
        
        XCTAssertThrowsError(try sut.bSToAD(day: 1, month: month, year: 0))
    }
    
    func test_bSToAd_throwsErrorWhenDayIsGreaterThan32() {
        let day = 33
        let sut = DateConverter()
        
        XCTAssertThrowsError(try sut.bSToAD(day: day, month: 1, year: 0))
    }
}
