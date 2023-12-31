//
//  DelayInfo.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 16.12.2023.
//

import Foundation

import Foundation

// MARK: - DelayInfo
struct DelayInfo: Codable {
    let response: [DelayResponse]
}
// MARK: - Response
struct DelayResponse: Codable {
    let airlineIata, flightIata: String?
    let depIata: String?
    let arrIata: String?
    let status: String?
    let duration, delayed, depDelayed, arrDelayed: Int?
    let aircraftIcao: String?

    enum CodingKeys: String, CodingKey {
        case airlineIata = "airline_iata"
        case flightIata = "flight_iata"
        case depIata = "dep_iata"
        case arrIata = "arr_iata"
        case status, duration, delayed
        case depDelayed = "dep_delayed"
        case arrDelayed = "arr_delayed"
        case aircraftIcao = "aircraft_icao"
    }
}

var delayedFlightArray: [DelayResponse] = []
var filteredDelayArray: [DelayResponse] = []
