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
              let days = try? daysCount(toADDate: date) else {
            throw invalidDateError
        }
        
        return try BSFrom(days: days)
    }
    
    private static func daysCount(toADDate date: NCDate) throws -> Int {
        guard let interval = try? date.date().timeIntervalSince(NCCalendar.firstDateInAD) else {
            throw invalidDateError
        }
        
        let daysInFraction = (interval+NCCalendar.differenceInTimeZone) / 24 / 60 / 60
    
        if daysInFraction < 0 {
            throw invalidDateError
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
        
        throw invalidDateError
    }
    
}
