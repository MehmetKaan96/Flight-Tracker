//
//  FlightDataService.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 17.11.2023.
//

import Foundation

protocol FlightDataService {
    func fetchFlights(completion: @escaping(Result<[Flights], NetworkError>) -> Void)
    func fetchFlightInfo(with flightCode: String, completion: @escaping(Result<FlightInfoResponse, NetworkError>) -> Void)
    func getAirport(with code: String, completion: @escaping(Result<Airport, NetworkError>) -> Void)
    func fetchDelayedFlights(with type: String, and minutes: String, completion: @escaping(Result<DelayInfo, NetworkError>) -> Void)
}
