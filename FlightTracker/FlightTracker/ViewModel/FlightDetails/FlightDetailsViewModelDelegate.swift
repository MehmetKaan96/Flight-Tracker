//
//  FlightDetailsViewModelDelegate.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 25.11.2023.
//

import Foundation

protocol FlightDetailsViewModelDelegate {
    func fetchFlightData(_ flight: FlightInfoResponse)
    func fetchDepartureAirport(_ airport: Airport)
    func fetchArrivalAirport(_ airport: Airport)
    func checkStatus(_ flight: FlightInfoResponse)
}

extension FlightDetailsViewModelDelegate {
    func checkStatus(_ flight: FlightInfoResponse) {}
}
