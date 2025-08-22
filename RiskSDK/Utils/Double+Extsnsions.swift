//
//  Double+Extsnsions.swift
//  Risk
//
//  Created by Igor on 8/17/25.
//

import CoreLocation

extension Double {
    var stringKilometers: String {
        String(format: "%.3f", self)
    }
    var stringMagnitude: String {
        String(format: "%.2f", self)
    }
}
