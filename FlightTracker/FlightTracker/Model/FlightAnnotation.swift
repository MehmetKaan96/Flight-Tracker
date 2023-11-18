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

    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, direction: Double) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.direction = direction
    }
}
