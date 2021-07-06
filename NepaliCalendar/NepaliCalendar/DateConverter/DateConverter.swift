//
//  DateConverter.swift
//  NepaliCalendar
//
//  Created by alok subedi on 01/05/2021.
//

public final class DateConverter {
    
    public static func BSToAD(date: NCDate) throws -> NCDate {
        try BSToADConverter.convert(date: date, firstDateInAD: NCCalendar.firstDateInAD)
    }
    
    public static func ADToBS(date: NCDate) throws -> NCDate {
        try ADToBSConverter.convert(date: date)
    }
    
}
