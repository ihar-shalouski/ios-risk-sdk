//
//  GeoJSONGeometry.swift
//  Risk
//
//  Created by Igor on 8/17/25.
//

import Foundation

public struct GeoJSONGeometry: Codable, Equatable, Sendable {
    public var type: String?
    public var coordinates: [Double] // [longitude, latitude, depth]
}
