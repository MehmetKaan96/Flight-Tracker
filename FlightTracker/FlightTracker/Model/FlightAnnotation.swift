//
//  FlightAnnotation.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 18.11.2023.
//

import Foundation
import MapKit

class FlightAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var direction: Double
    var flightIATA: String
    var depIATA: String
    var arrIATA: String

    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, direction: Double, flight_iata: String, dep_iata: String, arr_iata: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.direction = direction
        self.flightIATA = flight_iata
        self.depIATA = dep_iata
        self.arrIATA = arr_iata
    }
}
