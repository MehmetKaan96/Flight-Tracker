//
//  MainViewControllerExtension.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 18.11.2023.
//

import Foundation
import MapKit

extension MainViewController: RealtimeFlightsViewModelDelegate {
    func fetchFlights(_ flights: [Flights]) {
        DispatchQueue.main.async {
            flightsArray = flights
            self.showFlightsOnMap()
        }
    }
    
    func showFlightsOnMap() {
        for flight in flightsArray {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                guard let dir = flight.dir else { return }
                let coordinate = CLLocationCoordinate2D(latitude: flight.lat, longitude: flight.lng)
                let flightAnnotation = FlightAnnotation(coordinate: coordinate, title: nil, subtitle: nil, direction: dir)
                self.mapView.addAnnotation(flightAnnotation)
            }
        }
    }
}


extension MainViewController: MKMapViewDelegate {

    //Change pins to airplanes
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let flightAnnotation = annotation as? FlightAnnotation else { return nil }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
        annotationView.image = UIImage(named: "airplane")
        annotationView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        let radians = flightAnnotation.direction * .pi / 180.0
        
        annotationView.transform = CGAffineTransform(rotationAngle: CGFloat(radians))
        
        return annotationView
    }
}
