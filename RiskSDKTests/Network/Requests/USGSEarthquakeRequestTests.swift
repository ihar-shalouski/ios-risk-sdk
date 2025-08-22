//
//  USGSEarthquakeRequestTests.swift
//  Risk
//
//  Created by Igor on 8/22/25.
//

import CoreLocation
import Foundation
import RiskSDK
import Testing

@Suite("USGSEarthquakeRequest tests")
struct USGSEarthquakeRequestTests {
    private var emptyLocation: USGSEarthquakeRequest.Location {
        .circleDegreese(coordinate: .init(), radiusDegreese: 0.0)
    }
    @Test("makeURLRequest.url.")
    func makeURLRequestURL() async throws {
        let request = USGSEarthquakeRequest(location: emptyLocation)
        let url = try #require(request.makeURLRequest().url)
        let components = url.absoluteString.components(separatedBy: "?")
        #expect(components[0] == "https://earthquake.usgs.gov/fdsnws/event/1/query")
    }

    @Test("queryItems.circleDegreese")
    func queryItemsCircleDegreese() async throws {
        let request = USGSEarthquakeRequest(
            location: .circleDegreese(
                coordinate: CLLocationCoordinate2D(latitude: 35.123456, longitude: -12.987654),
                radiusDegreese: 1.124
            )
        )
        let queryItems = try await request.querryItems()
        #expect(queryItems.asDictionary(removingLocationAndFormat: false) == [
            "format": "geojson",
            "longitude": "-12.987654",
            "latitude": "35.123456",
            "maxradius": "1.124000",
        ])
    }

    @Test("queryItems.circleKilometers")
    func queryItemsCircleKilometers() async throws {
        let request = USGSEarthquakeRequest(
            location: .circleKilometers(
                coordinate: CLLocationCoordinate2D(latitude: -0.431112, longitude: 84.889213),
                radiusKilimeters: 6.75
            )
        )
        let queryItems = try await request.querryItems()
        #expect(queryItems.asDictionary(removingLocationAndFormat: false) == [
            "format": "geojson",
            "latitude": "-0.431112",
            "longitude": "84.889213",
            "maxradiuskm": "6.750",
        ])
    }

    @Test("queryItems.rectangle")
    func queryItemsRectangle() async throws {
        let request = USGSEarthquakeRequest(
            location: .rectangle(
                minLatitude: -44.399120,
                maxLatitude: 54.397612,
                minLongitude: 71.204951,
                maxLongitude: -21.998431
            )
        )
        let queryItems = try await request.querryItems()
        #expect(queryItems.asDictionary(removingLocationAndFormat: false) == [
            "format": "geojson",
            "minlatitude": "-44.399120",
            "minlongitude": "71.204951",
            "maxlatitude": "54.397612",
            "maxlongitude": "-21.998431"
        ])
    }

    @Test("queryItems.starttime")
    func queryItemsStartTime() async throws {
        let request = USGSEarthquakeRequest(
            location: emptyLocation,
            time: USGSEarthquakeRequest.Time(startTime: Date(timeIntervalSince1970: 30.0))
        )
        let queryItems = try await request.querryItems()
        #expect(queryItems.asDictionary() == ["starttime": "1970-01-01T00:00:30"])
    }

    @Test("queryItems.endtime")
    func queryItemsEndTime() async throws {
        let request = USGSEarthquakeRequest(
            location: emptyLocation,
            time: USGSEarthquakeRequest.Time(endTime: Date(timeIntervalSince1970: 45.0))
        )
        let queryItems = try await request.querryItems()
        #expect(queryItems.asDictionary() == ["endtime": "1970-01-01T00:00:45"])
    }

    @Test("queryItems.updatedafter")
    func queryItemsUpdatedAfter() async throws {
        let request = USGSEarthquakeRequest(
            location: emptyLocation,
            time: .init(updatedAfter: Date(timeIntervalSince1970: 90.0))
        )
        let queryItems = try await request.querryItems()
        #expect(queryItems.asDictionary() == ["updatedafter": "1970-01-01T00:01:30"])
    }

    @Test("queryItems.offset")
    func queryItemsOffset() async throws {
        let request = USGSEarthquakeRequest(location: emptyLocation, offset: 25)
        let queryItems = try await request.querryItems()
        #expect(queryItems.asDictionary() == ["offset": "25"])
    }

    @Test("queryItems.limit")
    func queryItemsLimit() async throws {
        let request = USGSEarthquakeRequest(location: emptyLocation, limit: 200)
        let queryItems = try await request.querryItems()
        #expect(queryItems.asDictionary() == ["limit": "200"])
    }

    @Test("queryItems.orderby.time")
    func queryItemsOrderByTime() async throws {
        let request = USGSEarthquakeRequest(location: emptyLocation, orderBy: .time)
        let queryItems = try await request.querryItems()
        #expect(queryItems.asDictionary() == ["orderby": "time"])
    }

    @Test("queryItems.orderby.time-asc")
    func queryItemsOrderByTimeAsc() async throws {
        let request = USGSEarthquakeRequest(location: emptyLocation, orderBy: .timeAsc)
        let queryItems = try await request.querryItems()
        #expect(queryItems.asDictionary() == ["orderby": "time-asc"])
    }

    @Test("queryItems.orderby.magnitude")
    func queryItemsOrderByMagnitude() async throws {
        let request = USGSEarthquakeRequest(location: emptyLocation, orderBy: .magnitude)
        let queryItems = try await request.querryItems()
        #expect(queryItems.asDictionary() == ["orderby": "magnitude"])
    }

    @Test("queryItems.orderby.magnitude-asc")
    func queryItemsOrderByMagnitudeAsc() async throws {
        let request = USGSEarthquakeRequest(location: emptyLocation, orderBy: .magnitudeAsc)
        let queryItems = try await request.querryItems()
        #expect(queryItems.asDictionary() == ["orderby": "magnitude-asc"])
    }

    @Test("queryItems.alertlevel")
    func queryItemsAlertLevel() async throws {
        let p = USGSEarthquakeRequest.Parameters(alertLevel: .yellow)
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["alertlevel": "yellow"])
    }

    @Test("queryItems.callback")
    func queryItemsCallback() async throws {
        let p = USGSEarthquakeRequest.Parameters(callback: "cbk")
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["callback": "cbk"])
    }

    @Test("queryItems.catalog")
    func queryItemsCatalog() async throws {
        let p = USGSEarthquakeRequest.Parameters(catalog: "comcat")
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["catalog": "comcat"])
    }

    @Test("queryItems.contributor")
    func queryItemsContributor() async throws {
        let p = USGSEarthquakeRequest.Parameters(contributor: "us")
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["contributor": "us"])
    }

    @Test("queryItems.eventid")
    func queryItemsEventId() async throws {
        let p = USGSEarthquakeRequest.Parameters(eventId: "abc123")
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["eventid": "abc123"])
    }

    @Test("queryItems.eventtype")
    func queryItemsEventType() async throws {
        let p = USGSEarthquakeRequest.Parameters(eventType: "earthquake")
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["eventtype": "earthquake"])
    }

    // MARK: - Parameters (booleans)

    @Test("queryItems.includeallmagnitudes")
    func queryItemsIncludeAllMagnitudes() async throws {
        let p = USGSEarthquakeRequest.Parameters(includeAllMagnitudes: true)
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["includeallmagnitudes": "true"])
    }

    @Test("queryItems.includeallorigins")
    func queryItemsIncludeAllOrigins() async throws {
        let p = USGSEarthquakeRequest.Parameters(includeAllOrigins: false)
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["includeallorigins": "false"])
    }

    @Test("queryItems.includearrivals")
    func queryItemsIncludeArrivals() async throws {
        let p = USGSEarthquakeRequest.Parameters(includeArrivals: true)
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["includearrivals": "true"])
    }

    @Test("queryItems.includedeleted")
    func queryItemsIncludeDeleted() async throws {
        let p = USGSEarthquakeRequest.Parameters(includeDeleted: true)
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["includedeleted": "true"])
    }

    @Test("queryItems.includesuperseded")
    func queryItemsIncludeSuperseded() async throws {
        let p = USGSEarthquakeRequest.Parameters(includeSuperseded: true)
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["includesuperseded": "true"])
    }

    @Test("queryItems.maxdepth (km)")
    func queryItemsMaxDepth() async throws {
        let p = USGSEarthquakeRequest.Parameters(maxDepth: 70.0)
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["maxdepth": "70.000"])
    }

    @Test("queryItems.maxmagnitude")
    func queryItemsMaxMagnitude() async throws {
        let p = USGSEarthquakeRequest.Parameters(maxMagnitude: 7.5)
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["maxmagnitude": "7.50"])
    }

    @Test("queryItems.maxcdi")
    func queryItemsMaxCDI() async throws {
        let p = USGSEarthquakeRequest.Parameters(maxCDI: 3.2)
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["maxcdi": "3.20"])
    }

    @Test("queryItems.maxgap (deg)")
    func queryItemsMaxGap() async throws {
        let p = USGSEarthquakeRequest.Parameters(maxGap: 120.0)
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["maxgap": "120.000000"])
    }

    @Test("queryItems.maxmmi")
    func queryItemsMaxMMI() async throws {
        let p = USGSEarthquakeRequest.Parameters(maxMMI: 5.5)
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["maxmmi": "5.50"])
    }

    @Test("queryItems.maxsig")
    func queryItemsMaxSignificance() async throws {
        let p = USGSEarthquakeRequest.Parameters(maxSignificance: 600)
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["maxsig": "600"])
    }

    @Test("queryItems.mincdi")
    func queryItemsMinCDI() async throws {
        let p = USGSEarthquakeRequest.Parameters(minCDI: 1.0)
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["mincdi": "1.00"])
    }

    @Test("queryItems.mindepth (km)")
    func queryItemsMinDepth() async throws {
        let p = USGSEarthquakeRequest.Parameters(minDepth: 0.125)
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["mindepth": "0.125"])
    }

    @Test("queryItems.minfelt")
    func queryItemsMinFelt() async throws {
        let p = USGSEarthquakeRequest.Parameters(minFelt: 10)
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["minfelt": "10"])
    }

    @Test("queryItems.mingap (deg)")
    func queryItemsMinGap() async throws {
        let p = USGSEarthquakeRequest.Parameters(minGap: 5.0)
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["mingap": "5.000000"])
    }

    @Test("queryItems.minmagnitude")
    func queryItemsMinMagnitude() async throws {
        let p = USGSEarthquakeRequest.Parameters(minMagnitude: 2.5)
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["minmagnitude": "2.50"])
    }

    @Test("queryItems.minsig")
    func queryItemsMinSignificance() async throws {
        let p = USGSEarthquakeRequest.Parameters(minSignificance: 100)
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["minsig": "100"])
    }

    @Test("queryItems.nodata")
    func queryItemsNoData() async throws {
        let p = USGSEarthquakeRequest.Parameters(noData: 404)
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["nodata": "404"])
    }

    @Test("queryItems.productcode")
    func queryItemsProductCode() async throws {
        let p = USGSEarthquakeRequest.Parameters(productCode: "xyz")
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["productcode": "xyz"])
    }

    @Test("queryItems.producttype")
    func queryItemsProductType() async throws {
        let p = USGSEarthquakeRequest.Parameters(productType: "phase-data")
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["producttype": "phase-data"])
    }

    @Test("queryItems.reviewstatus")
    func queryItemsReviewStatus() async throws {
        let p = USGSEarthquakeRequest.Parameters(reviewStatus: .reviewed)
        let queryItems = try await USGSEarthquakeRequest(location: emptyLocation, parameters: p).querryItems()
        #expect(queryItems.asDictionary() == ["reviewstatus": "reviewed"])
    }

    @Test("execute")
    func execute() async throws {
        let url = try #require(Bundle.module.url(forResource: "usgs", withExtension: "json"))
        let data = try Data(contentsOf: url)
        let transport = MockNetworkTransport(data: data)
        let result = try await transport.execute(for: USGSEarthquakeRequest(location: emptyLocation))

       #expect(result.type == "FeatureCollection")
       #expect(result.metadata?.status == 200)
       #expect(result.metadata?.title == "USGS Earthquakes")
       #expect(result.metadata?.count == 504)

       #expect(result.features.count == 4)

       let f0 = result.features[0]
       #expect(f0.id == "tx2025abcxyz")
       #expect(f0.properties.mag == 1.6)
       #expect(f0.properties.place == "12 km W of Stanton, Texas")
       #expect(f0.properties.code == "2025abcxyz")
       #expect(f0.properties.net == "tx")
       #expect(f0.geometry.coordinates == [-101.92, 32.1, 4.9])

       let f1 = result.features[1]
       #expect(f1.id == "tx2025defuvw")
       #expect(f1.properties.mag == 1.4)
       #expect(f1.properties.place == "14 km WSW of Stanton, Texas")
       #expect(f1.properties.code == "2025defuvw")
       #expect(f1.properties.magType == "mlv")

       let f2 = result.features[2]
       #expect(f2.id == "tx2025ghijk")
       #expect(f2.properties.mag == 2.1)
       #expect(f2.properties.place == "21 km NE of Monahans, Texas")
       #expect(f2.geometry.coordinates == [-102.72, 31.7, 8.2])

       let f3 = result.features[3]
       #expect(f3.id == "tx2025lmnoop")
       #expect(f3.properties.mag == 1.1)
       #expect(f3.properties.place == "23 km WSW of Coyanosa, Texas")
       #expect(f3.properties.types == ",origin,phase-data,")
    }
}

extension Array where Element == URLQueryItem {
    private static let locationAndFormatKeys = Set(["format", "minlatitude", "minlongitude", "maxlatitude", "maxlongitude", "latitude", "longitude", "maxradiuskm", "maxradius"])
    func asDictionary(removingLocationAndFormat: Bool = true) -> [String: String] {
        reduce(into: [:]) { result, item in
            guard !removingLocationAndFormat || !Self.locationAndFormatKeys.contains(item.name) else { return }
            result[item.name] = item.value
        }
    }
}

extension NetworkRequest {
    func querryItems() async throws -> [URLQueryItem] {
        let request = try makeURLRequest()
        let url = try #require(request.url)
        let urlComponents = try #require(URLComponents(url: url, resolvingAgainstBaseURL: false))
        let queryItems = try #require(urlComponents.queryItems)
        return queryItems
    }
}

