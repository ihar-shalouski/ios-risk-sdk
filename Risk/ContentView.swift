//
//  ContentView.swift
//  Risk
//
//  Created by Igor on 8/16/25.
//

import CoreLocation
import RiskSDK
import SwiftUI

struct ContentView: View {
    let config = RiskSDKConfig()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Hello") {
                Task {
                    do {
                        let result = try await config.networkTransport.execute(
                            for: USGSEarthquakeRequest(
                                location: .circleKilometers(
                                    coordinate: CLLocationCoordinate2D(latitude: 31.84831, longitude: -101.77179),
                                    radiusKilimeters: 200.0
                                )
                            )
                        )
                        dump(result)
                    } catch {
                        print("Error")
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


