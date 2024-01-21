//
//  RealtimeFlightsViewModel.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 18.11.2023.
//

import Foundation

final class RealtimeFlightsViewModel {
    private let flightsService: FlightDataService
    
    var delegate: RealtimeFlightsViewModelDelegate?
    
    init(flightsService: FlightDataService) {
        self.flightsService = flightsService
    }
    
    func fetchFlights() {
        flightsService.fetchFlights { result in
            switch result {
            case .success(let result):
                self.delegate?.fetchFlights(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
