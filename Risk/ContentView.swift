//
//  ContentView.swift
//  Risk
//
//  Created by Igor on 8/16/25.
//

import CoreLocation
import RiskSDK
import SwiftUI

private struct RiskSDKConfigEnvironmentKey: EnvironmentKey {
    static let defaultValue: RiskSDKConfig = RiskSDKConfig()
}

extension EnvironmentValues {
    var riskSDK: RiskSDKConfig {
        get { self[RiskSDKConfigEnvironmentKey.self] }
        set { self[RiskSDKConfigEnvironmentKey.self] = newValue }
    }
}

struct ContentView: View {
    @Environment(\.riskSDK) var riskSDK

    var body: some View {
        VStack {
            Button("USGS Earthquake") {
                Task {
                    do {
                        let result = try await riskSDK.networkTransport.execute(
                            for: USGSEarthquakeRequest(
                                location: .circleKilometers(
                                    coordinate: CLLocationCoordinate2D(latitude: 31.84831, longitude: -101.77179),
                                    radiusKilimeters: 200.0
                                )
                            )
                        )
                        dump(result)
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
