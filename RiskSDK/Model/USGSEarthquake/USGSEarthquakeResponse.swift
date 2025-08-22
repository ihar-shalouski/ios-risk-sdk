//
//  USGSEarthquakeResponse.swift
//  Risk
//
//  Created by Igor on 8/17/25.
//

import Foundation

public struct USGSEarthquakeResponse: Codable, Equatable, Sendable {
    public var type: String?
    public var metadata: GeoJSONMetadata?
    public var features: [EarthquakeFeature]
    public var bbox: [Double]?
}
