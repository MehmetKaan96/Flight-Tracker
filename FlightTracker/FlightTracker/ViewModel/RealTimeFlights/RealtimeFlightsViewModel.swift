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
    var flightsArray: [Flights] = []
    var filteredArray: [Flights] = []
    
    init(flightsService: FlightDataService) {
        self.flightsService = flightsService
    }
    
    func fetchFlights() {
        flightsService.fetchFlights { result in
            switch result {
            case .success(let result):
                self.flightsArray = result
                self.delegate?.fetchFlights(self.flightsArray)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
