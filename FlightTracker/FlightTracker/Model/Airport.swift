//
//  Airport.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 25.11.2023.
//

import Foundation

// MARK: - Airport
struct Airport: Codable {
    let response: [Response]
}

// MARK: - Response
struct Response: Codable {
    let name, iataCode, icaoCode: String
    let lat, lng: Double
    let countryCode: String

    enum CodingKeys: String, CodingKey {
        case name
        case iataCode = "iata_code"
        case icaoCode = "icao_code"
        case lat, lng
        case countryCode = "country_code"
    }
}
