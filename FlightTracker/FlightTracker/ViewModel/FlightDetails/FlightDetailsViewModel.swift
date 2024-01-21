//
//  FlightDetailsViewModel.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 25.11.2023.
//

import Foundation

final class FlightDetailsViewModel {
    private let flightService: FlightDataService
    
    var delegate: FlightDetailsViewModelDelegate?
    
    init(service: FlightDataService) {
        self.flightService = service
    }
    
    func fetchFlightInfo(with name: String) {
        flightService.fetchFlightInfo(with: name) { result in
            switch result {
            case .success(let info):
                self.delegate?.fetchFlightData(info)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchDepartureAirport(with code: String) {
        flightService.getAirport(with: code) { result in
            switch result {
            case .success(let airport):
                self.delegate?.fetchDepartureAirport(airport)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchArrivalAirport(with code: String) {
        flightService.getAirport(with: code) { result in
            switch result {
            case .success(let airport):
                self.delegate?.fetchArrivalAirport(airport)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
