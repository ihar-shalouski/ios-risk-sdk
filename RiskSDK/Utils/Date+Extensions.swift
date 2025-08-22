//
//  Date+Extensions.swift
//  Risk
//
//  Created by Igor on 8/17/25.
//

import Foundation

extension Date {
    // TODO: is self.ISO8601Format() the same?
    var iso8601String: String {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = .utc
        formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        return formatter.string(from: self)
    }
}
