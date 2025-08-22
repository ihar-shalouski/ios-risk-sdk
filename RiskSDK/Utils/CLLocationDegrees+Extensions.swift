//
//  CLLocationDegrees+Extension.swift
//  Risk
//
//  Created by Igor on 8/17/25.
//

import CoreLocation

extension CLLocationDegrees {
    var stringDegrees: String {
        String(format: "%.6f", self)
    }
}
