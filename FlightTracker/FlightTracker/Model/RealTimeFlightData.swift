//
//  RealTimeFlightData.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 17.11.2023.
//

import Foundation

struct FlightsResponse: Codable {
    let response: [Flights]
}

struct Flights: Codable {
    let reg_number: String?
    let flag: String?
    let lat: Double?
    let lng: Double?
    let alt: Int?
    let dir: Double?
    let speed: Int?
    let v_speed: Double?
    let flight_number: String?
    let flight_icao: String?
    let flight_iata: String?
    let dep_icao: String?
    let dep_iata: String?
    let arr_icao: String?
    let arr_iata: String?
    let airline_icao: String?
    let airline_iata: String?
    let aircraft_icao: String?
    let status: String?
}

