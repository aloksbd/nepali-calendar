//
//  DateFormatter + InitWithTimeZone.swift
//  NepaliCalendar
//
//  Created by alok subedi on 04/07/2021.
//

extension DateFormatter {
    convenience init(timeZone: TimeZone) {
        self.init()
        self.timeZone = timeZone
        self.dateFormat = "dd MM yyyy"
    }
}
