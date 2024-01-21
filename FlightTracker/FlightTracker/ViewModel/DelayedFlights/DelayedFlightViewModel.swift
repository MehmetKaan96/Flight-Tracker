//
//  DelayedFlightViewModel.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 16.12.2023.
//

import Foundation

final class DelayedFlightViewModel {
    private let flightService: FlightDataService
    
    var delegate: DelayedFlightViewModelDelegate?
    
    init(flightService: FlightDataService) {
        self.flightService = flightService
    }
    
    func getDelayedFlights(with type: String, and minutes: String) {
        flightService.fetchDelayedFlights(with: type, and: minutes) { result in
            switch result {
            case .success(let delayedInfo):
                self.delegate?.getDelayedFlights(delayedInfo.response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
