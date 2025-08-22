//
//  NetworkTransportError.swift
//  Risk
//
//  Created by Igor on 8/22/25.
//

import Foundation

public enum NetworkTransportError: Error {
    case cannotBuildRequest, invalidResponse
}
