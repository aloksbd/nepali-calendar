//
//  ADToBSConverter.swift
//  NepaliCalendar
//
//  Created by alok subedi on 06/07/2021.
//

class ADToBSConverter {
    
    static let invalidDateError = NSError(domain: "Invalid Date", code: 0)
    
    public static func convert(date: NCDate) throws -> NCDate {
        guard DateValidator.validateADDate(date),
              let days = try? daysCountSinceFirstADDate(toADDate: date) else {
            throw invalidDateError
        }
        
        return try BSFrom(days: days)
    }
    
    private static func daysCountSinceFirstADDate(toADDate date: NCDate) throws -> Int {
        guard let timeIntervalSinceFirstDate = try? date.date().timeIntervalSince(NCCalendar.firstDateInAD) else {
            throw invalidDateError
        }
        
        let totalDaysWhenFirstDayIsZero = daysFromTimeInterval(timeIntervalSinceFirstDate)
        if totalDaysWhenFirstDayIsZero < 0 {
            throw invalidDateError
        }
        
        let totalDaysWhenFirstDayIsOne = Int(totalDaysWhenFirstDayIsZero) + 1
        return totalDaysWhenFirstDayIsOne
    }
    
    private static func daysFromTimeInterval(_ timeInterval: TimeInterval) -> Double {
        let timeIntervalForOneDay: Double = 24 * 60 * 60
        let timeIntervalOnCurrentTimeZone = timeInterval + NCCalendar.differenceInTimeZone
        let totalDays = timeIntervalOnCurrentTimeZone / timeIntervalForOneDay
    
        return totalDays
    }
    
    private static func BSFrom(days: Int) throws -> NCDate {
        let (year, daysUntilLastYear) = try year(from: days)
        let daysInGivenYear = days - daysUntilLastYear
        
        guard let daysInMonths = NCCalendar.bs[year] else { throw invalidDateError }
        let (day, month) = try dayAndMonth(from: daysInGivenYear, daysInMonths: daysInMonths)
        return NCDate(day: day, month: month, year: year)
    }
    
    private static func year(from days: Int) throws -> (year: Int, daysUntilLastYear: Int) {
        var daysUntilLastYear = 0
        for (year, daysInMonths) in NCCalendar.bs.sorted(by: { $0.key < $1.key }) {
            daysUntilLastYear += daysInMonths.reduce(0, +)
            if daysUntilLastYear > days {
                daysUntilLastYear -= daysInMonths.reduce(0, +)
                return (year, daysUntilLastYear)
            }
        }
        throw invalidDateError
    }
    
    private static func dayAndMonth(from days: Int, daysInMonths: [Int]) throws -> (day: Int, month: Int) {
        var addedDays = 0
        for i in 0..<12 {
            addedDays += daysInMonths[i]
            if addedDays > days {
                let day = daysInMonths[i] - addedDays + days
                return (day: day, month: i + 1)
            }
        }
        throw invalidDateError
    }
    
}
