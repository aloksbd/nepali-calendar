//
//  DateConverter.swift
//  NepaliCalendar
//
//  Created by alok subedi on 01/05/2021.
//

public final class DateConverter {
    
    public init() {}
    
    public func bSToAD(day: Int, month: Int, year: Int) throws -> (day: Int, month: Int, year: Int) {
        if !validateDate(day: day, month: month, year: year) {
            throw NSError()
        }
        
        return (0,0,0)
    }
    
    private func validateDate(day: Int, month: Int, year: Int) -> Bool {
        return validateRange(day: day, month: month, year: year)
    }
    
    private func validateRange(day: Int, month: Int, year: Int) -> Bool {
        if validateDay(day),
           validateMonth(month),
           validateYear(year){
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
