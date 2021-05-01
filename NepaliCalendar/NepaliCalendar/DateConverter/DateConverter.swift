//
//  DateConverter.swift
//  NepaliCalendar
//
//  Created by alok subedi on 01/05/2021.
//

public final class DateConverter {
    
    public init() {}
    
    public func bSToAD(date: NCDate) throws -> (day: Int, month: Int, year: Int) {
        if !validateDate(date: date) {
            throw NSError()
        }
        
        return (0,0,0)
    }
    
    private func validateDate(date: NCDate) -> Bool {
        return validateRange(date: date)
    }
    
    private func validateRange(date: NCDate) -> Bool {
        if validateDay(date.day),
           validateMonth(date.month),
           validateYear(date.year){
            return true
        }
        
        return false
    }
    
    private func validateDay(_ day: Int) -> Bool {
        let validDays = (1...32)
        if validDays.contains(day) {
            return true
        }
        return false
    }
    
    private func validateMonth(_ month: Int) -> Bool {
        let validMonths = (1...12)
        if validMonths.contains(month) {
            return true
        }
        return false
    }
    
    private func validateYear(_ year: Int) -> Bool {
        let validYears = (2078...2078)
        if validYears.contains(year) {
            return true
        }
        return false
    }
    
}
