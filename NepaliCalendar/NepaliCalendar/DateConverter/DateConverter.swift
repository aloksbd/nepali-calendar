//
//  DateConverter.swift
//  NepaliCalendar
//
//  Created by alok subedi on 01/05/2021.
//

public final class DateConverter {
    
    public init() {}
    
    public func bSToAD(day: Int, month: Int, year: Int) throws -> (day: Int, month: Int, year: Int) {
        if !validateDateFormat(day: day, month: month, year: year) {
            throw NSError()
        }
        
        return (0,0,0)
    }
    
    private func validateDateFormat(day: Int, month: Int, year: Int) -> Bool {
        if day == 0 || month == 0 {
            return false
        }
        return true
    }
    
}
