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
            flightsArray = flights.compactMap { flight in
                guard flight.aircraft_icao != nil,
                      flight.dir != nil,
                      flight.arr_iata != nil,
                      flight.dep_iata != nil,
                      flight.dep_iata != nil,
                      flight.flight_iata != nil,
                      flight.airline_iata != nil,
                      flight.airline_icao != nil,
                      flight.alt != nil,
                      flight.arr_icao != nil,
                      flight.dep_icao != nil,
                      flight.flag != nil,
                      flight.flight_icao != nil,
                      flight.flight_number != nil,
                      flight.reg_number != nil,
                      flight.speed != nil,
                      flight.status != nil,
                      flight.v_speed != nil else {
                    return nil
                }
                return flight
            }
            self.showFlightsOnMap()
        }
    }
    
    func showFlightsOnMap() {
        for flight in flightsArray {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                guard let dir = flight.dir else { return }
                let coordinate = CLLocationCoordinate2D(latitude: flight.lat, longitude: flight.lng)
                guard let iata = flight.flight_iata, let dep = flight.dep_iata, let arr = flight.arr_iata else { return }
                let flightAnnotation = FlightAnnotation(coordinate: coordinate, title: nil, subtitle: nil, direction: dir, flight_iata: iata, dep_iata: dep, arr_iata: arr)
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

        let adjustedRadians = radians - (.pi / 2)
        annotationView.transform = CGAffineTransform(rotationAngle: CGFloat(adjustedRadians))
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        guard let flightAnnotation = annotation as? FlightAnnotation else { return }
        
        let detailViewController = MiniDetailPageViewController(viewModel: FlightDetailsViewModel(service: APIManager()), selectedIATA: flightAnnotation.flightIATA, dep_iata: flightAnnotation.depIATA, arr_iata: flightAnnotation.arrIATA)
        
        if let sheet = detailViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.sourceView?.layer.borderWidth = 1
            
            self.present(detailViewController, animated: true)
        }
        
    }
}
