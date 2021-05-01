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
        let datesLessThanOne = [(0, 0), (-1, -1), (-10, -10), (1, -1), (-1, 2)]
        
        try? datesLessThanOne.forEach { (day, month) in
            XCTAssertThrowsError(try DateConverter.bSToAD(date: NCDate(day: day, month: month, year: 2078)))
        }
    }
    
    func test_bSToAd_throwsErrorWhenMonthIsGreaterThan12() {
        let monthsGreaterThan12 = [13, 24, 100]
        
        try? monthsGreaterThan12.forEach { XCTAssertThrowsError(try DateConverter.bSToAD(date: NCDate(day: 1, month: $0, year: 0))) }
    }
    
    func test_bSToAd_throwsErrorWhenDayIsGreaterThan32() {
        let daysGreaterThan32 = [33, 40, 100]
        
        try? daysGreaterThan32.forEach { XCTAssertThrowsError(try DateConverter.bSToAD(date: NCDate(day: $0, month: 1, year: 0))) }
    }
    
    func test_bSToAd_throwsErrorWhenYearIsNotThisYear() {
        let invalidYears = [1, 2077, 2079, 100000]
        
        try? invalidYears.forEach { XCTAssertThrowsError(try DateConverter.bSToAD(date: NCDate(day: $0, month: 1, year: $0))) }
    }
    
    func test_bSToAd_throwsErrorWhenDayIsInvalidForGivenMonthOfYear() {
        let invalidDaysForMonthOfYear = [(32, 2, 2078), (30, 8, 2078), (31, 12, 2078)]
        
        try? invalidDaysForMonthOfYear.forEach { (day, month, year) in
            XCTAssertThrowsError(try DateConverter.bSToAD(date: NCDate(day: day, month: month, year: year)))
        }
    }
    
}
