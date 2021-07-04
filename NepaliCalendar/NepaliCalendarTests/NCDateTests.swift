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
        let expectedNCDate = NCDate(day: 12, month: 5, year: 2021)
        
        let sut = NCDate(from: date, timeZone: TimeZone(identifier: "Asia/Kathmandu")!)
        
        XCTAssertEqual(sut, expectedNCDate)
    }
    
    func test_convertNCDateToDate_throwsInvalidDateOnInvalidNCDate() {
        let invalidNCDates = [
            NCDate(day: 23, month: 32, year: 2020),
            NCDate(day: 90, month: 12, year: 2020),
            NCDate(day: 12, month: 32, year: 2020),
        ]
        
        try? invalidNCDates.forEach { XCTAssertThrowsError(try $0.date()) }
    }
    
    func test_convertNCDateToDate_returnsConvertedDate() {
        validNCDates().forEach { (sut, expectedDate) in
            XCTAssertEqual(try? sut.date(timeZone: TimeZone(identifier: "GMT")!), expectedDate)
        }
    }

    private func validNCDates() -> [(datesToBeConverted: NCDate, expectedDates: Date)] {
        return [
            (NCDate(day: 1, month: 12, year: 2020), Date(timeIntervalSince1970: TimeInterval(1606780800))),
            (NCDate(day: 6, month: 12, year: 9999), Date(timeIntervalSince1970: TimeInterval(253400054400))),
            (NCDate(day: 5, month: 1, year: 1111), Date(timeIntervalSince1970: TimeInterval(-27106531200))),
            (NCDate(day: 13, month: 5, year: 50000), Date(timeIntervalSince1970: TimeInterval(1515691872000))),
        ]
    }
    
}
