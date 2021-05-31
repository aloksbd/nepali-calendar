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
        if !validateDate(date) {
            throw Error.invalidRange
        }
        
        let timestamp = totalDays(from: date) * 24 * 60 * 60
        let convertedDate =  Date(timeInterval: TimeInterval(timestamp), since: firstDateInAD)
        
        return NCDate(from: convertedDate)
    }
    
    public static func ADToBS(date: NCDate) throws -> NCDate {
        if !validateDay(date.day) ||
           !validateMonth(date.month) ||
           !(date.year >= 1943 && date.year <= 2033) {
            throw Error.invalidRange
        }
        
        let interval = try! date.date().timeIntervalSince(firstDateInAD)
        let days = Int(interval / 24 / 60 / 60) + 1
        
        return try BSFrom(days: days)
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
    
    private static func totalDays(from date: NCDate) -> Int {
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
    
    private static func validateDate(_ date: NCDate) -> Bool {
        if let daysInMonth = BSDates.bs[date.year],
           validateMonth(date.month) && validateDay(date.day) {
            let dateAsIndexForBS = date.month - 1
            if date.day <= daysInMonth[dateAsIndexForBS] {
                return true
            }
        }
        
        return false
    }
    
    private static func validateDay(_ day: Int) -> Bool {
        let validDays = (1...32)
        if validDays.contains(day) {
            return true
        }
        
        return false
    }
    
    private static func validateMonth(_ month: Int) -> Bool {
        let validMonths = (1...12)
        if validMonths.contains(month) {
            return true
        }
        
        return false
    }
    
}
