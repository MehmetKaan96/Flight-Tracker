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
    
    var delayedFlightArray: [DelayResponse] = []
    var filteredDelayArray: [DelayResponse] = []
    
    init(flightService: FlightDataService) {
        self.flightService = flightService
    }
    
    func getDelayedFlights(with type: String, and minutes: String) {
        flightService.fetchDelayedFlights(with: type, and: minutes) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let delayedInfo):
                self.delayedFlightArray = delayedInfo.response
                self.delegate?.getDelayedFlights(self.delayedFlightArray)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
