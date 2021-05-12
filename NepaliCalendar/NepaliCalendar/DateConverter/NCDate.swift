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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"

        let dateString = dateFormatter.string(from: date)
        let dateComponents = dateString.split(separator: " ").map { Int($0)! }
        
        day = dateComponents[2]
        month = dateComponents[1]
        year = dateComponents[0]
    }
    
}
