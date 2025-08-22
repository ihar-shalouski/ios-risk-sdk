//
//  USGSEarthquakeRequest.swift
//  Risk
//
//  Created by Igor on 8/16/25.
//

import CoreLocation
import Foundation

public struct USGSEarthquakeRequest: NetworkRequest {
    public typealias Response = USGSEarthquakeResponse
    
    public enum AlertLevel: String, Sendable {
        case green, yellow, orange, red
    }
    public enum Location: Sendable {
        case rectangle(minLatitude: CLLocationDegrees, maxLatitude: CLLocationDegrees, minLongitude: CLLocationDegrees, maxLongitude: CLLocationDegrees)
        case circleDegreese(coordinate: CLLocationCoordinate2D, radiusDegreese: CLLocationDegrees)
        case circleKilometers(coordinate: CLLocationCoordinate2D, radiusKilimeters: Double)
    }

    public enum OrderBy: String, Sendable {
        case time
        case timeAsc = "time-asc"
        case magnitude
        case magnitudeAsc = "magnitude-asc"
    }

    public struct Parameters: Sendable {
        public var alertLevel: AlertLevel?
        public var callback: String?
        public var catalog: String?
        public var contributor: String?
        public var eventId: String?
        public var eventType: String?
        public var includeAllMagnitudes: Bool?
        public var includeAllOrigins: Bool?
        public var includeArrivals: Bool?
        public var includeDeleted: Bool?
        public var includeSuperseded: Bool?
        public var maxDepth: Double?
        public var maxMagnitude: Double?
        public var maxCDI: Double?
        public var maxGap: CLLocationDegrees?
        public var maxMMI: Double?
        public var maxSignificance: Int?
        public var minCDI: Double?
        public var minDepth: Double?
        public var minFelt: Int?
        public var minGap: CLLocationDegrees?
        public var minMagnitude: Double?
        public var minSignificance: Int?
        public var noData: Int?
        public var productCode: String?
        public var productType: String?
        public var reviewStatus: ReviewStatus?

        public init(
            alertLevel: AlertLevel? = nil,
            callback: String? = nil,
            catalog: String? = nil,
            contributor: String? = nil,
            eventId: String? = nil,
            eventType: String? = nil,
            includeAllMagnitudes: Bool? = nil,
            includeAllOrigins: Bool? = nil,
            includeArrivals: Bool? = nil,
            includeDeleted: Bool? = nil,
            includeSuperseded: Bool? = nil,
            maxDepth: Double? = nil,
            maxMagnitude: Double? = nil,
            maxCDI: Double? = nil,
            maxGap: CLLocationDegrees? = nil,
            maxMMI: Double? = nil,
            maxSignificance: Int? = nil,
            minCDI: Double? = nil,
            minDepth: Double? = nil,
            minFelt: Int? = nil,
            minGap: CLLocationDegrees? = nil,
            minMagnitude: Double? = nil,
            minSignificance: Int? = nil,
            noData: Int? = nil,
            productCode: String? = nil,
            productType: String? = nil,
            reviewStatus: ReviewStatus? = nil
        ) {
            self.alertLevel = alertLevel
            self.callback = callback
            self.catalog = catalog
            self.contributor = contributor
            self.eventId = eventId
            self.eventType = eventType
            self.includeAllMagnitudes = includeAllMagnitudes
            self.includeAllOrigins = includeAllOrigins
            self.includeArrivals = includeArrivals
            self.includeDeleted = includeDeleted
            self.includeSuperseded = includeSuperseded
            self.maxDepth = maxDepth
            self.maxMagnitude = maxMagnitude
            self.maxCDI = maxCDI
            self.maxGap = maxGap
            self.maxMMI = maxMMI
            self.maxSignificance = maxSignificance
            self.minCDI = minCDI
            self.minDepth = minDepth
            self.minFelt = minFelt
            self.minGap = minGap
            self.minMagnitude = minMagnitude
            self.minSignificance = minSignificance
            self.noData = noData
            self.productCode = productCode
            self.productType = productType
            self.reviewStatus = reviewStatus
        }

        var items: [URLQueryItem] {
            var result = [URLQueryItem]()
            if let alertLevel {
                result.append(URLQueryItem(name: "alertlevel", value: alertLevel.rawValue))
            }
            if let catalog {
                result.append(URLQueryItem(name: "catalog", value: catalog))
            }
            if let callback {
                result.append(URLQueryItem(name: "callback", value: callback))
            }
            if let contributor {
                result.append(URLQueryItem(name: "contributor", value: contributor))
            }
            if let eventId {
                result.append(URLQueryItem(name: "eventid", value: eventId))
            }
            if let eventType {
                result.append(URLQueryItem(name: "eventtype", value: eventType))
            }
            if let includeAllMagnitudes {
                result.append(URLQueryItem(name: "includeallmagnitudes", value: includeAllMagnitudes.stringBool))
            }
            if let includeAllOrigins {
                result.append(URLQueryItem(name: "includeallorigins", value: includeAllOrigins.stringBool))
            }
            if let includeArrivals {
                result.append(URLQueryItem(name: "includearrivals", value: includeArrivals.stringBool))
            }
            if let includeDeleted {
                result.append(URLQueryItem(name: "includedeleted", value: includeDeleted.stringBool))
            }
            if let includeSuperseded {
                result.append(URLQueryItem(name: "includesuperseded", value: includeSuperseded.stringBool))
            }
            if let maxCDI {
                result.append(URLQueryItem(name: "maxcdi", value: maxCDI.stringMagnitude))
            }
            if let maxDepth {
                result.append(URLQueryItem(name: "maxdepth", value: maxDepth.stringKilometers))
            }
            if let maxGap {
                result.append(URLQueryItem(name: "maxgap", value: maxGap.stringDegrees))
            }
            if let maxMagnitude {
                result.append(URLQueryItem(name: "maxmagnitude", value: maxMagnitude.stringMagnitude))
            }
            if let maxMMI {
                result.append(URLQueryItem(name: "maxmmi", value: maxMMI.stringMagnitude))
            }
            if let maxSignificance {
                result.append(URLQueryItem(name: "maxsig", value: String(maxSignificance)))
            }
            if let minCDI {
                result.append(URLQueryItem(name: "mincdi", value: minCDI.stringMagnitude))
            }
            if let minDepth {
                result.append(URLQueryItem(name: "mindepth", value: minDepth.stringKilometers))
            }
            if let minFelt {
                result.append(URLQueryItem(name: "minfelt", value: String(minFelt)))
            }
            if let minGap {
                result.append(URLQueryItem(name: "mingap", value: minGap.stringDegrees))
            }
            if let minMagnitude {
                result.append(URLQueryItem(name: "minmagnitude", value: minMagnitude.stringMagnitude))
            }
            if let minSignificance {
                result.append(URLQueryItem(name: "minsig", value: String(minSignificance)))
            }
            if let noData {
                result.append(URLQueryItem(name: "nodata", value: String(noData)))
            }
            if let productCode {
                result.append(URLQueryItem(name: "productcode", value: productCode))
            }
            if let productType {
                result.append(URLQueryItem(name: "producttype", value: productType))
            }
            if let reviewStatus {
                result.append(URLQueryItem(name: "reviewstatus", value: reviewStatus.rawValue))
            }
            return result
        }
    }

    public enum ReviewStatus: String, Sendable {
        case all, automatic, reviewed
    }

    public struct Time: Sendable {
        public var startTime: Date?
        public var endTime: Date?
        public var updatedAfter: Date?

        public init(startTime: Date? = nil, endTime: Date? = nil, updatedAfter: Date? = nil) {
            self.startTime = startTime
            self.endTime = endTime
            self.updatedAfter = updatedAfter
        }
    }
    
    private let location: Location
    private let time: Time?
    private let offset: Int?
    private let limit: Int?
    private let orderBy: OrderBy?
    private let parameters: Parameters?

    public init(
        location: Location,
        time: Time? = nil,
        offset: Int? = nil,
        limit: Int? = nil,
        orderBy: OrderBy? = nil,
        parameters: Parameters? = nil
    ) {
        self.location = location
        self.time = time
        self.offset = offset
        self.limit = limit
        self.orderBy = orderBy
        self.parameters = parameters
    }

    public func makeURLRequest() throws -> URLRequest {
        var items = [URLQueryItem]()
        items.append(URLQueryItem(name: "format", value: "geojson"))
        switch location {
        case .rectangle(
            minLatitude: let minLatitude,
            maxLatitude: let maxLatitude,
            minLongitude: let minLongitude,
            maxLongitude: let maxLongitude
        ):
            items.append(URLQueryItem(name: "minlatitude", value: minLatitude.stringDegrees))
            items.append(URLQueryItem(name: "maxlatitude", value: maxLatitude.stringDegrees))
            items.append(URLQueryItem(name: "minlongitude", value: minLongitude.stringDegrees))
            items.append(URLQueryItem(name: "maxlongitude", value: maxLongitude.stringDegrees))
        case .circleKilometers(
            coordinate: let coordinate,
            radiusKilimeters: let radiusKilimeters
        ):
            items.append(URLQueryItem(name: "latitude", value: coordinate.latitude.stringDegrees))
            items.append(URLQueryItem(name: "longitude", value: coordinate.longitude.stringDegrees))
            items.append(URLQueryItem(name: "maxradiuskm", value: radiusKilimeters.stringKilometers))
        case .circleDegreese(
            coordinate: let coordinate,
            radiusDegreese: let radiusDegreese
        ):
            items.append(URLQueryItem(name: "latitude", value: coordinate.latitude.stringDegrees))
            items.append(URLQueryItem(name: "longitude", value: coordinate.longitude.stringDegrees))
            items.append(URLQueryItem(name: "maxradius", value: radiusDegreese.stringDegrees))
        }
        if let time {
            if let startTime = time.startTime {
                items.append(URLQueryItem(name: "starttime", value: startTime.iso8601String))
            }
            if let endTime = time.endTime {
                items.append(URLQueryItem(name: "endtime", value: endTime.iso8601String))
            }
            if let updatedAfter = time.updatedAfter {
                items.append(URLQueryItem(name: "updatedafter", value: updatedAfter.iso8601String))
            }
        }
        if let offset {
            items.append(URLQueryItem(name: "offset", value: String(offset)))
        }
        if let limit {
            items.append(URLQueryItem(name: "limit", value: String(limit)))
        }
        if let orderBy {
            items.append(URLQueryItem(name: "orderby", value: orderBy.rawValue))
        }
        if let parameters {
            items = items + parameters.items
        }

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "earthquake.usgs.gov"
        urlComponents.path = "/fdsnws/event/1/query"
        urlComponents.queryItems = items
        guard let url = urlComponents.url else {
            throw NetworkTransportError.cannotBuildRequest
        }
        return URLRequest(url: url)
    }

}

