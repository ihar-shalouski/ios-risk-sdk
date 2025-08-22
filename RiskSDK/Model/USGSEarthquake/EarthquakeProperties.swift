//
//  EarthquakeProperties.swift
//  Risk
//
//  Created by Igor on 8/17/25.
//

import Foundation

public struct EarthquakeProperties: Codable, Equatable, Sendable {
    public var mag: Double?
    public var place: String?
    public var time: Date?
    public var updated: Date?
    public var tz: Int? // Timezone offset, can be null
    public var url: String?
    public var detail: String?
    public var felt: Int? // Number of felt reports
    public var cdi: Double? // Community Determined Intensity
    public var mmi: Double? // Modified Mercalli Intensity
    public var alert: String? // Alert level
    public var status: String?
    public var tsunami: Int?
    public var sig: Int?
    public var net: String?
    public var code: String?
    public var ids: String?
    public var sources: String?
    public var types: String?
    public var nst: Int?
    public var dmin: Double?
    public var rms: Double?
    public var gap: Double?
    public var magType: String?
    public var title: String?
}
