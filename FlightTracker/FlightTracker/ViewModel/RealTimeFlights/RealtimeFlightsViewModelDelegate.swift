//
//  RealtimeFlightsViewModelDelegate.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 18.11.2023.
//

import Foundation

protocol RealtimeFlightsViewModelDelegate {
    func fetchFlights(_ flights: [Flights])
    func filterFlightsAndShowOnMap(_ filteredFlights: [Flights])
}
