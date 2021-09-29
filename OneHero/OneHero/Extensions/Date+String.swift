//
//  Date+String.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation

extension Date {
    /// 03/01/2019
    var mmDDYYY: String {
        return dateString(format: "MM/dd/yyyy")
    }

    /// Mar 01
    var mmmDD: String {
        return dateString(format: "MMM dd")
    }

    /// Fri, 1 Mar 2019 2:22 PM
    var dayMonthYearTime: String {
        return dateString(format: "E, d MMM yyyy h:mm a")
    }

    /// Fri, 1 Mar 2019
    var dayMonthYear: String {
        return dateString(format: "E, d MMM yyyy")
    }

    static func getDateFromISO8601(string: String) throws -> Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: string)
    }

    func dateString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format

        let formatedDate = formatter.string(from: self)
        return formatedDate
    }

    func toString() -> String {
        return Log.dateFormatter.string(from: self as Date)
    }

    /// This method returns number of days in current month
    static func getDaysInMonth() -> Int {
        let calendar = Calendar.current

        let dateComponents = DateComponents(year: calendar.component(.year, from: Date()), month: calendar.component(.month, from: Date()))
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count

        return numDays
    }
    
    func toMilliseconds() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
