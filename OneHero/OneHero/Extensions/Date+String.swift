//
//  Date+String.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation

extension Date {
    func dateString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format

        let formatedDate = formatter.string(from: self)
        return formatedDate
    }

    func toString() -> String {
        return Log.dateFormatter.string(from: self as Date)
    }
    
    func toMilliseconds() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
