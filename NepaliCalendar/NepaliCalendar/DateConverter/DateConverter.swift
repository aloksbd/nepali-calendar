//
//  DateConverter.swift
//  NepaliCalendar
//
//  Created by alok subedi on 01/05/2021.
//

public final class DateConverter {
    
    private static var firstDateInAD: Date {
        return Date(timeIntervalSince1970: -843264000)
    }
    
    public enum Error: Swift.Error {
        case invalidRange
    }
    
    public static func bSToAD(date: NCDate) throws -> NCDate {
        if !DateValidator.validateBSDate(date) {
            throw Error.invalidRange
        }
        
        let timestamp = daysCount(toBSDate: date) * 24 * 60 * 60
        let convertedDate =  Date(timeInterval: TimeInterval(timestamp), since: firstDateInAD)
        
        return NCDate(from: convertedDate)
    }
    
    public static func ADToBS(date: NCDate) throws -> NCDate {
        guard DateValidator.validateADDate(date),
              let days = try? daysCount(toADDate: date) else {
            throw Error.invalidRange
        }
        
        return try BSFrom(days: days)
    }
    
    private static func daysCount(toADDate date: NCDate) throws -> Int {
        guard let interval = try? date.date().timeIntervalSince(firstDateInAD) else {
            throw Error.invalidRange
        }
        
        let daysInFraction = interval / 24 / 60 / 60
    
        if daysInFraction < 0 {
            throw Error.invalidRange
        }
        
        return Int(daysInFraction) + 1
    }
    
    private static func BSFrom(days: Int) throws -> NCDate {
        var totalDays = 0
        for (key, val) in BSDates.bs.sorted(by: { $0.key < $1.key }) {
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
        
        throw Error.invalidRange
    }
    
    private static func daysCount(toBSDate date: NCDate) -> Int {
        var totalDays = 0
        for (key, val) in BSDates.bs.sorted(by: { $0.key < $1.key }) {
            if key == date.year {
                for i in 0..<date.month - 1 {
                    totalDays += val[i]
                }
                break
            }
            totalDays += val.reduce(0, +)
        }
        totalDays += date.day
        
        return totalDays
    }
    
}
