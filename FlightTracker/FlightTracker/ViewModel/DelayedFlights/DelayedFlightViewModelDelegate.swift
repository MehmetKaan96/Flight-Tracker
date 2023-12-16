//
//  DelayedFlightViewModelDelegate.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 16.12.2023.
//

import Foundation

protocol DelayedFlightViewModelDelegate {
    func getDelayedFlights(_ flights: [DelayResponse])
}
