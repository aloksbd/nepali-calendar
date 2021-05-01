//
//  DateConverter.swift
//  NepaliCalendar
//
//  Created by alok subedi on 01/05/2021.
//

public final class DateConverter {
    
    public static func bSToAD(date: NCDate) throws -> (day: Int, month: Int, year: Int) {
        if !validateDate(date: date) {
            throw NSError()
        }
        
        return (0,0,0)
    }
    
    private static func validateDate(date: NCDate) -> Bool {
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
