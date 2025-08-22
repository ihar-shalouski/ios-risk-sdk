//
//  MockNetworkTransport.swift
//  Risk
//
//  Created by Igor on 8/22/25.
//

import Foundation
import RiskSDK

struct MockNetworkTransport: NetworkTransport {
    var statusCode: Int = 200
    var data: Data?
    var error: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        return (data ?? Data(), HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!)
    }
    

}
