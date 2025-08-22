//
//  TimeZone+Extensions.swift
//  Risk
//
//  Created by Igor on 8/17/25.
//

import Foundation

extension TimeZone {
    static var utc: TimeZone {
        TimeZone(identifier: "UTC")!
    }
}
