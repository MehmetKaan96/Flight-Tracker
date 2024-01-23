//
//  FlightInfo.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 25.11.2023.
//

import Foundation

struct FlightInfo: Codable {
    let response: Info
}

struct Info: Codable {
    let aircraftIcao: String?
    let age, built: Int?
    let engine, engineCount, model, manufacturer: String?
    let msn, type, regNumber, airlineIata: String?
    let airlineIcao, flightIata, flightIcao, flightNumber: String?
    let depIata, depIcao, depTerminal, depGate: String?
    let depTime, depEstimated, depActual, depTimeUTC: String?
    let depEstimatedUTC, depActualUTC: String?
    let depTimeTs, depEstimatedTs, depActualTs: Int?
    let arrIata, arrIcao, arrTerminal, arrGate: String?
    let arrBaggage, arrTime, arrEstimated: String?
    let arrTimeUTC, arrEstimatedUTC: String?
    let arrTimeTs, arrEstimatedTs: Int?
    let status: String?
    let duration: Int?
    let lat, lng: Double?
    let dir: Double?
//    let alt, dir, speed: Int?
    let depName, depCity, depCountry: String?
    let arrName, arrCity, arrCountry, airlineName: String?

    enum CodingKeys: String, CodingKey {
        case aircraftIcao = "aircraft_icao"
        case age, built, engine
        case engineCount = "engine_count"
        case model, manufacturer, msn, type
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
        case depEstimated = "dep_estimated"
        case depActual = "dep_actual"
        case depTimeUTC = "dep_time_utc"
        case depEstimatedUTC = "dep_estimated_utc"
        case depActualUTC = "dep_actual_utc"
        case depTimeTs = "dep_time_ts"
        case depEstimatedTs = "dep_estimated_ts"
        case depActualTs = "dep_actual_ts"
        case arrIata = "arr_iata"
        case arrIcao = "arr_icao"
        case arrTerminal = "arr_terminal"
        case arrGate = "arr_gate"
        case arrBaggage = "arr_baggage"
        case arrTime = "arr_time"
        case arrEstimated = "arr_estimated"
        case arrTimeUTC = "arr_time_utc"
        case arrEstimatedUTC = "arr_estimated_utc"
        case arrTimeTs = "arr_time_ts"
        case arrEstimatedTs = "arr_estimated_ts"
        case status
        case duration
        case lat, lng
        case dir
//        case alt, dir, speed
        case depName = "dep_name"
        case depCity = "dep_city"
        case depCountry = "dep_country"
        case arrName = "arr_name"
        case arrCity = "arr_city"
        case arrCountry = "arr_country"
        case airlineName = "airline_name"
    }
}
