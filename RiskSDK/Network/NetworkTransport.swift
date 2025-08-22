//
//  NetworkTransport.swift
//  Risk
//
//  Created by Igor on 8/22/25.
//

import Foundation

public protocol NetworkTransport: Sendable {
    func data(for: URLRequest) async throws -> (Data, URLResponse)
}

extension NetworkTransport {
    public func execute<Request: NetworkRequest>(for request: Request) async throws -> Request.Response {
        let urlRequest = try request.makeURLRequest()
        let (data, response) = try await data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse, request.isValid(httpResponse.statusCode) else {
            throw NetworkTransportError.invalidResponse
        }
        let decoder = request.decoder()
        return try decoder.decode(Request.Response.self, from: data)
    }
}

extension URLSession: NetworkTransport {
    // Already conforms
}

