//
//  DateConverterTests.swift
//  NepaliCalendarTests
//
//  Created by alok subedi on 01/05/2021.
//

import XCTest
import NepaliCalendar

class DateConverterTests: XCTestCase {
    
    func test_bSToAD_throwsErrorWhenDayOrMonthIsLessThanOne() {
        let datesLessThanOne = [(0, 0), (-1, -1), (-10, -10)]
        let sut = DateConverter()
        
        try? datesLessThanOne.forEach { (day, month) in
            XCTAssertThrowsError(try sut.bSToAD(day: day, month: month, year: 0))
        }
    }
    
    func test_bSToAd_throwsErrorWhenMonthIsGreaterThan12() {
        let monthsGreaterThan12 = [13, 24, 100]
        let sut = DateConverter()
        
        try? monthsGreaterThan12.forEach { XCTAssertThrowsError(try sut.bSToAD(day: 1, month: $0, year: 0)) }
    }
    
    func test_bSToAd_throwsErrorWhenDayIsGreaterThan32() {
        let daysGreaterThan32 = [33, 40, 100]
        let sut = DateConverter()
        
        try? daysGreaterThan32.forEach { XCTAssertThrowsError(try sut.bSToAD(day: $0, month: 1, year: 0)) }
    }
}
