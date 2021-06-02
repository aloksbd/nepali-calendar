//
//  DateValidator.swift
//  NepaliCalendar
//
//  Created by alok subedi on 02/06/2021.
//

class DateValidator {
    static func validateADDate(_ date: NCDate) -> Bool {
        if !validateDay(date.day) ||
            !validateMonth(date.month) ||
            !(date.year >= 1943 && date.year <= 2033) {
            return false
        }
        return true
    }
    
    static func validateBSDate(_ date: NCDate) -> Bool {
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

