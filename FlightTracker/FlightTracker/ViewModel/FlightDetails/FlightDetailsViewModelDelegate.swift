//
//  FlightDetailsViewModelDelegate.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 25.11.2023.
//

import Foundation

protocol FlightDetailsViewModelDelegate {
    func fetchFlightData(_ flight: FlightInfo)
}
