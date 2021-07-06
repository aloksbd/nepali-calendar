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
        var totalDays = 0
        for (key, val) in NCCalendar.bs.sorted(by: { $0.key < $1.key }) {
            totalDays += val.reduce(0, +)
            if totalDays > days {
                totalDays -= val.reduce(0, +)
                for i in 0..<12 {
                    totalDays += val[i]
                    if totalDays > days {
                        let day = val[i] - totalDays + days
                        return NCDate(day: day, month: i + 1, year: key)
                    }
                }
            }
        }
        
        throw invalidDateError
    }
    
}
