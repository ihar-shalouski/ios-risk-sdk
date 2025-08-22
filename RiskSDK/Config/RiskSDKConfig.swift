//
//  RiskSDKConfig.swift
//  Risk
//
//  Created by Igor on 8/16/25.
//

import Foundation

public struct RiskSDKConfig: Sendable {
    public var networkTransport: NetworkTransport

    public init(networkTransport: NetworkTransport = URLSession.shared) {
        self.networkTransport = networkTransport
    }
}
