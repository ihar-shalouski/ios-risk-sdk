# iOS Risk SDK

A lightweight starting point: SDK focused on integrating with the USGS Earthquake API. Small for now, but built to grow.

---

## Current Features

- **`USGSEarthquakeRequest`**: the main and only component at the moment, responsible for building network requests to the USGS Earthquake API.
- Clean and extensible architecture, designed to accommodate additional clients in the future.

---

## Installation

Add the SDK via Swift Package Manager using the repository URL:
https://github.com/ihar-shalouski/ios-risk-sdk

---

## Quick Example

```swift
import RiskSDK
Task {
    do {
        let result = try await RiskSDKConfig().networkTransport.execute(
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
