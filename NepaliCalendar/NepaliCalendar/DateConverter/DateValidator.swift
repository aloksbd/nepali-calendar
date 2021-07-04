//
//  DateValidator.swift
//  NepaliCalendar
//
//  Created by alok subedi on 02/06/2021.
//

class DateValidator {
    private static var firstADYear: Int { 1943 }
    private static var lastADYear: Int { 2033 }
    
    static func validateADDate(_ date: NCDate) -> Bool {
        let validADYear = (date.year >= firstADYear && date.year <= lastADYear)
        if !validateDay(date.day) ||
            !validateMonth(date.month) ||
            !validADYear {
            return false
        }
        return true
    }
    
    static func validateBSDate(_ date: NCDate) -> Bool {
        if let daysInMonths = BSDates.bs[date.year],
           validateMonth(date.month) && validateDay(date.day) {
            let monthIndex = date.month - 1
            if date.day <= daysInMonths[monthIndex] {
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

