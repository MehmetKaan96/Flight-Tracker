//
//  FlightInfo.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 30.06.2023.
//

import Foundation

struct InfoResponse: Codable {
    let response: [FlightInfo]
}

struct FlightInfoResponse: Codable {
    let response: FlightInfo
}

struct FlightInfo: Codable {
    let aircraftIcao, regNumber, airlineIata, airlineIcao: String?
    let flightIata, flightIcao, flightNumber, depIata: String?
    let depIcao, depTerminal, depGate, depTime: String?
    let depTimeUTC: String?
    let depTimeTs: Int?
    let arrIata, arrIcao, arrTerminal, arrBaggage, arrGate: String?
    let arrTime, arrTimeUTC: String?
    let arrTimeTs: Int?
    let status: String?
    let duration, updated: Int?
    let hex, flag: String?
    let lat, lng: Double?
    let alt, dir, speed: Int?
    let vSpeed: Double?
    let squawk, depName, depCity, depCountry: String?
    let arrName, arrCity, arrCountry, airlineName, arrEstimated: String?
    let percent: Int?
    let utc: String?
    let eta: Int?
    let delayed: Int?
    
    enum CodingKeys: String, CodingKey {
        case aircraftIcao = "aircraft_icao"
        case regNumber = "reg_number"
        case airlineIata = "airline_iata"
        case airlineIcao = "airline_icao"
        case flightIata = "flight_iata"
        case flightIcao = "flight_icao"
        case flightNumber = "flight_number"
        case depIata = "dep_iata"
        case depIcao = "dep_icao"
        case depTerminal = "dep_terminal"
        case depGate = "dep_gate"
        case depTime = "dep_time"
        case depTimeUTC = "dep_time_utc"
        case depTimeTs = "dep_time_ts"
        case arrIata = "arr_iata"
        case arrIcao = "arr_icao"
        case arrTerminal = "arr_terminal"
        case arrBaggage = "arr_baggage"
        case arrTime = "arr_time"
        case arrTimeUTC = "arr_time_utc"
        case arrTimeTs = "arr_time_ts"
        case status, duration, updated, hex, flag, lat, lng, alt, dir, speed
        case vSpeed = "v_speed"
        case squawk
        case depName = "dep_name"
        case depCity = "dep_city"
        case depCountry = "dep_country"
        case arrName = "arr_name"
        case arrCity = "arr_city"
        case arrCountry = "arr_country"
        case airlineName = "airline_name"
        case arrGate = "arr_gate"
        case arrEstimated = "arr_estimated"
        case percent, utc, eta, delayed
    }
}
