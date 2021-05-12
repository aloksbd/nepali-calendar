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
    
    public init(from date: Date) {
        let components = Calendar.current.dateComponents([.day,.month,.year], from: date)
        
        day = components.day!
        month = components.month!
        year = components.year!
    }
}
