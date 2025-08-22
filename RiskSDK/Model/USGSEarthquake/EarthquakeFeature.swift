//
//  EarthquakeFeature.swift
//  Risk
//
//  Created by Igor on 8/17/25.
//

import Foundation

public struct EarthquakeFeature: Codable, Equatable, Sendable {
    public var type: String
    public var properties: EarthquakeProperties
    public var geometry: GeoJSONGeometry
    public var id: String
}
