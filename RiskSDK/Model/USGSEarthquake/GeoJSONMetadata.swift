//
//  GeoJSONMetadata.swift
//  Risk
//
//  Created by Igor on 8/17/25.
//

import Foundation

public struct GeoJSONMetadata: Codable, Equatable, Sendable {
    public var generated: Date?
    public var url: String?
    public var title: String?
    public var status: Int?
    public var api: String?
    public var count: Int?
}
