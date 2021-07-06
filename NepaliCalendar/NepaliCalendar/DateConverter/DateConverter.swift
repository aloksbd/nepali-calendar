//
//  DateConverter.swift
//  NepaliCalendar
//
//  Created by alok subedi on 01/05/2021.
//

public final class DateConverter {
    
    public enum Error: Swift.Error {
        case invalidRange
    }
    
    public static func BSToAD(date: NCDate) throws -> NCDate {
        try BSToADConverter.convert(date: date, firstDateInAD: NCCalendar.firstDateInAD)
    }
    
    public static func ADToBS(date: NCDate) throws -> NCDate {
        guard DateValidator.validateADDate(date),
              let days = try? daysCount(toADDate: date) else {
            throw Error.invalidRange
        }
        
        return try BSFrom(days: days)
    }
    
    private static func daysCount(toADDate date: NCDate) throws -> Int {
        guard let interval = try? date.date().timeIntervalSince(NCCalendar.firstDateInAD) else {
            throw Error.invalidRange
        }
        
        let daysInFraction = (interval+NCCalendar.differenceInTimeZone) / 24 / 60 / 60
    
        if daysInFraction < 0 {
            throw Error.invalidRange
        }
        
        return Int(daysInFraction) + 1
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
        
        throw Error.invalidRange
    }
    
}
