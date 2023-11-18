//
//  FlightDataService.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 17.11.2023.
//

import Foundation

protocol FlightDataService {
    func fetchFlights(completion: @escaping(Result<[Flights], NetworkError>) -> Void)
}
