//
//  RealtimeFlightsViewModel.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 18.11.2023.
//

import Foundation
enum FilterCriteria: Int {
    case scheduled = 1
    case enRoute = 2
    case landed = 3
}

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
    
    func filterFlights(by status: Int) {
        let filter = FilterCriteria(rawValue: status)
        
        switch filter {
        case .scheduled:
            filteredArray = flightsArray.filter({$0.status == "scheduled"})
        case .enRoute:
            filteredArray = flightsArray.filter({$0.status == "en-route"})
        case .landed:
            filteredArray = flightsArray.filter({$0.status == "landed"})
        default:
            filteredArray = flightsArray
        }
        
        delegate?.filterFlightsAndShowOnMap(filteredArray)
    }
}
