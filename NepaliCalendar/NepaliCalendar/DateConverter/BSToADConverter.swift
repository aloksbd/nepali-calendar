//
//  BSToADConverter.swift
//  NepaliCalendar
//
//  Created by alok subedi on 06/07/2021.
//

final class BSToADConverter {
    
    private static let invalidDateError = NSError(domain: "Invalid Date", code: 0)
    
    static func convert(date: NCDate) throws -> NCDate {
        if !DateValidator.validateBSDate(date) {
            throw invalidDateError
        }
        
        let timestampForOneDay = 24 * 60 * 60
        let timestamp = daysCountSinceFirstBSDate(toBSDate: date) * timestampForOneDay
        let convertedDate =  Date(timeInterval: TimeInterval(timestamp), since: NCCalendar.firstDateInAD)
        
        return NCDate(from: convertedDate)
    }
    
    private static func daysCountSinceFirstBSDate(toBSDate date: NCDate) -> Int {
        let totalDaysBeforeGivenMonth = totalDaysBeforeGivenMonth(date: date)
        let totalDays = totalDaysBeforeGivenMonth + date.day
        let totalDaysWhenFirstDayIsZero = totalDays - 1  //
        
        return totalDaysWhenFirstDayIsZero
    }
    
    private static func totalDaysBeforeGivenMonth(date: NCDate) -> Int{
        var totalDaysBeforeGivenMonth = 0
        for (year, daysInMonths) in NCCalendar.sortedBS {
            if year == date.year {
                totalDaysBeforeGivenMonth += totalDaysBefore(month: date.month, in: daysInMonths)
                break
            }
            let totalDaysInCurrentYear = daysInMonths.reduce(0, +)
            totalDaysBeforeGivenMonth += totalDaysInCurrentYear
        }
        return totalDaysBeforeGivenMonth
    }
    
    private static func totalDaysBefore(month: Int, in daysInMonths: [Int]) -> Int {
        var totalDays = 0
        for i in 0..<month - 1 {
            totalDays += daysInMonths[i]
        }
        return totalDays
    }
    
}
