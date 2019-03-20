//
//  Date+Extension.swift
//  Arya
//
//  Created by Bhavik Barot on 14/09/18.
//  Copyright © 2018 Bhavik Barot. All rights reserved.
//

import Foundation

enum ReportMonth: Int {
    
    case oneMonth = -1
    case threeMonth = -3
    case sixMonth = -6
    case twelveMonth = -12
}

extension Formatter {
    
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let iso8601DateTimer: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    static let calendarDateFormattor: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        return formatter

    }()
}

extension Date {
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
    var iso8601DateTimer: String {
        return Formatter.iso8601DateTimer.string(from: self)
    }
    
    var calendarDate: String {
        return Formatter.calendarDateFormattor.string(from: self)
    }
    
    func getDateOf(month: ReportMonth) -> Date {

        return Calendar.current.date(byAdding: .month, value: month.rawValue, to: self)!

    }
}
