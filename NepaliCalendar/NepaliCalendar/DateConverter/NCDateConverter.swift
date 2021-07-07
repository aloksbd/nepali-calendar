//
//  NCDateConverter.swift
//  NepaliCalendar
//
//  Created by alok subedi on 01/05/2021.
//

public final class NCDateConverter {
    
    public static func BSToAD(date: NCDate) throws -> NCDate {
        try BSToADConverter.convert(date: date)
    }
    
    public static func ADToBS(date: NCDate) throws -> NCDate {
        try ADToBSConverter.convert(date: date)
    }
    
}
