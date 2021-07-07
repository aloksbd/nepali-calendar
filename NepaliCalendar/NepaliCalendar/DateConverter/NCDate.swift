//
//  NCDate.swift
//  NepaliCalendar
//
//  Created by alok subedi on 01/05/2021.
//

public struct NCDate: Equatable {
    
    public let day: Int
    public let month: Int
    public let year: Int
    
    public init(day: Int, month: Int, year: Int) {
        self.day = day
        self.month = month
        self.year = year
    }
    
    public init(from date: Date, timeZone: TimeZone = .current) {
        let dateFormatter = DateFormatter(timeZone: timeZone)

        let dateString = dateFormatter.string(from: date)
        let dateComponents = dateString.split(separator: " ").map { Int($0) ?? 0 }
        
        day = dateComponents[0]
        month = dateComponents[1]
        year = dateComponents[2]
    }
    
    public func date(timeZone: TimeZone = .current) throws -> Date {
        let NCDateString = "\(day) \(month) \(year)"
        let dateFormatter = DateFormatter(timeZone: timeZone)
        guard let date = dateFormatter.date(from: NCDateString) else {
            throw NSError()
        }
        return date
    }
}
