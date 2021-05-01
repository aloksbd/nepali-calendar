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
    
}
