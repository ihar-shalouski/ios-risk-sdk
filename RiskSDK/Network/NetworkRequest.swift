//
//  NetworkRequest.swift
//  Risk
//
//  Created by Igor on 8/22/25.
//

import Foundation

public protocol NetworkRequest: Sendable {
    associatedtype Response: Decodable & Sendable
    func makeURLRequest() throws -> URLRequest
    func decoder() -> JSONDecoder
    func isValid(_ code: Int) -> Bool
}

extension NetworkRequest {
    public func isValid(_ code: Int) -> Bool {
        (200..<300).contains(code)
    }

    public func decoder() -> JSONDecoder {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .millisecondsSince1970
        return d
    }
}
