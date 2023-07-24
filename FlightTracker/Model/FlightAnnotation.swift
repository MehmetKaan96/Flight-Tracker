//
//  FlightAnnotation.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 29.06.2023.
//

import Foundation
import MapKit

class FlightAnnotation: NSObject, MKAnnotation {
    let flight: Flights
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: flight.lat, longitude: flight.lng)
    }
    var title: String? {
        return flight.flightIata
    }
    var subtitle: String? {
        return flight.status
    }
    
    init(flight: Flights) {
        self.flight = flight
        super.init()
    }
}
