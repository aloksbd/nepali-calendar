//
//  DateConverterTests.swift
//  NepaliCalendarTests
//
//  Created by alok subedi on 01/05/2021.
//

import XCTest
import NepaliCalendar

class DateConverterTests: XCTestCase {
    
    func test_BSToAD_throwsErrorForInvalidMonths() {
        let invalidMonths = invalidMonths()
        
        try? invalidMonths.forEach { XCTAssertThrowsError(try DateConverter.bSToAD(date: NCDate(day: anyValidDay, month: $0, year: anyValidYear))) }
    }
    
    func test_BSToAD_throwsErrorForInvalidDays() {
        let invalidDays = invalidDays()
        
        try? invalidDays.forEach { XCTAssertThrowsError(try DateConverter.bSToAD(date: NCDate(day: $0, month: anyValidMonth, year: anyValidYear))) }
    }
    
    func test_BSToAD_throwsErrorWhenYearIsNotInRange() {
        let invalidYears = [1, 100, 5000, 100000, 1999, 2091]
        
        try? invalidYears.forEach { XCTAssertThrowsError(try DateConverter.bSToAD(date: NCDate(day: anyValidDay, month: anyValidMonth, year: $0))) }
    }
    
    func test_BSToAD_throwsErrorWhenDayIsInvalidForGivenMonthOfYear() {
        let invalidDaysForMonthOfYear = [(32, 2, 2078), (30, 8, 2079), (30, 10, 2080)]
        
        try? invalidDaysForMonthOfYear.forEach { (day, month, year) in
            XCTAssertThrowsError(try DateConverter.bSToAD(date: NCDate(day: day, month: month, year: year)))
        }
    }
    
    func test_BSToAD_returnConvertedDate() {
        validNCDates().forEach { (dateToBeConverted, expectedDate) in
            XCTAssertEqual(try? DateConverter.bSToAD(date: dateToBeConverted), expectedDate)
        }
    }

    func test_ADToBS_throwsErrorForInvalidMonths() {
        let invalidMonths = invalidMonths()

        try? invalidMonths.forEach { XCTAssertThrowsError(try DateConverter.ADToBS(date: NCDate(day: anyValidDay, month: $0, year: anyValidYear))) }
    }

    func test_ADToBS_throwsErrorForInvalidDays() {
        let invalidDays = invalidDays()

        try? invalidDays.forEach { XCTAssertThrowsError(try DateConverter.ADToBS(date: NCDate(day: $0, month: anyValidMonth, year: anyValidYear))) }
    }

    func test_ADToBS_throwsErrorWhenYearIsNotInRange() {
        let invalidYears = [1, 100, 5000, 100000, 1942, 2091]

        try? invalidYears.forEach { XCTAssertThrowsError(try DateConverter.ADToBS(date: NCDate(day: anyValidDay, month: anyValidMonth, year: $0))) }
    }

    func test_ADToBS_throwsErrorWhenDayIsInvalidForGivenMonthOfYear() {
        let invalidDaysForMonthOfYear = [(30, 2, 2020), (32, 8, 1943), (31, 4, 2030)]

        try? invalidDaysForMonthOfYear.forEach { (day, month, year) in
            XCTAssertThrowsError(try DateConverter.ADToBS(date: NCDate(day: day, month: month, year: year)))
        }
    }
    
    func test_ADToBS_throwsErrorWhenGivenDayAndMonthIsNotInRange() {
        let invalidDaysForMonthOfYear = [(20, 8, 1933), (13, 4, 1943), (14, 4, 2034), (10, 10, 3000)]

        try? invalidDaysForMonthOfYear.forEach { (day, month, year) in
            XCTAssertThrowsError(try DateConverter.ADToBS(date: NCDate(day: day, month: month, year: year)))
        }
    }

    func test_ADToBS_returnConvertedDate() {
        validNCDates().forEach { (expectedDate, dateToBeConverted) in
            XCTAssertEqual(try? DateConverter.ADToBS(date: dateToBeConverted), expectedDate)
        }
    }
    
    //MARK: Helpers
    
    private func invalidMonths() -> [Int] {
        let monthsGreaterThan12 = [13, 24, 100]
        let monthsLessThanOne = [0, -1, -10]
        return monthsGreaterThan12 + monthsLessThanOne
    }
    
    private func invalidDays() -> [Int] {
        let daysGreaterThan32 = [33, 40, 100]
        let daysLessThanOne = [0, -1, -10]
        return daysGreaterThan32 + daysLessThanOne
    }
    
    private var anyValidDay: Int {
        1
    }
    
    private var anyValidMonth: Int {
        1
    }
    
    private var anyValidYear: Int {
        2000
    }
    
    private func validNCDates() -> [(BS: NCDate, AD: NCDate)] {
        return [
            (NCDate(day: 01, month: 01, year: 2000), NCDate(day: 14, month: 04, year: 1943)),
            (NCDate(day: 19, month: 12, year: 2052), NCDate(day: 1, month: 04, year: 1996)),
            (NCDate(day: 10, month: 6, year: 2049), NCDate(day: 26, month: 09, year: 1992))
        ]
    }
}
