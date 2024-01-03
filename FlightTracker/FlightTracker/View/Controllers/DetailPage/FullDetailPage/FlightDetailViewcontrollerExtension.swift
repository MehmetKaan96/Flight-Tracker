//
//  FlightDetailViewcontrollerExtension.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 18.12.2023.
//

import Foundation
import MapKit

extension FlightDetailViewController: FlightDetailsViewModelDelegate {
    func fetchFlightData(_ flight: FlightInfo) {
        DispatchQueue.main.async { [self] in
            let flight = flight.response
            setupAircraftDetails(flight)
            setupAirportDetails(page.departureDetail, flight.depGate, "Departure Airport Info", flight.depTerminal, flight.depActual)
            setupAirportDetails(page.arrivalDetail, flight.arrGate, "Arrival Airport Info", flight.arrTerminal, flight.arrTime)
            page.depAndArrCountry.text = "\(flight.depCity ?? "N/A") to \(flight.arrCity ?? "N/A")"
            
            guard let dir = flight.dir, let lat = flight.lat, let lng = flight.lng else {
                print("Error: Direction, Latitude, or Longitude is nil")
                return
            }
            
            print("Setting plane location and direction...")
            self.planeLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            self.direction = dir
            
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let flightAnnotation = FlightAnnotation(coordinate: coordinate, title: nil, subtitle: nil, direction: dir, flight_iata: "", dep_iata: "", arr_iata: "")
            page.mapView.addAnnotation(flightAnnotation)
            info = flight
            addFlightToRealm(flight: info)
            showAnnotationsOnMap()
        }
    }
    
    private func setupAircraftDetails(_ response: Info) {
        page.planeModel.text = response.model
        
        page.aircraftDetail1.setInfoDetail1(with: response.manufacturer)
        page.aircraftDetail1.setInfoDetail2(with: response.type)
        page.aircraftDetail1.setInfoDetail3(with: response.engine)
        
        if let built = response.built, let age = response.age {
            page.aircraftDetail2.setInfoDetail1(with: "\(built)")
            page.aircraftDetail2.setInfoDetail2(with: "\(age)")
            page.aircraftDetail2.setInfoDetail3(with: response.engineCount)
        } else {
            page.aircraftDetail2.setInfoDetail1(with: "N/A")
            page.aircraftDetail2.setInfoDetail2(with: "N/A")
            page.aircraftDetail2.setInfoDetail3(with: "N/A")
        }
        
        page.dateAndIataLabel.text = "\(response.depTime ?? "N/A") \(response.flightIata ?? "N/A")"
    }
    
    private func setupAirportDetails(_ airportDetail: AirportDetailView, _ gate: String?, _ info: String, _ terminal: String?, _ time: String?) {
        airportDetail.setGate(with: gate)
        airportDetail.setAirport(with: info)
        airportDetail.setTerminal(with: terminal)
        airportDetail.setArrivalTime(with: time)
    }
    
    func fetchDepartureAirport(_ airport: Airport) {
        DispatchQueue.main.async { [self] in
            page.departureDetail.setAirportName(using: airport.response.first?.name ?? "N/A")
            if let lat = airport.response.first?.lat, let lng = airport.response.first?.lng {
                self.departureLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                let annotation = MKPointAnnotation()
                annotation.coordinate = self.departureLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
                annotation.title = "Departure"
                self.page.mapView.addAnnotation(annotation)
            } else {
                print("Error: Latitude or Longitude is nil for departure")
            }
            showAnnotationsOnMap()
        }
    }
    
    func fetchArrivalAirport(_ airport: Airport) {
        DispatchQueue.main.async { [self] in
            page.arrivalDetail.setAirportName(using: airport.response.first?.name ?? "N/A")
            if let lat = airport.response.first?.lat, let lng = airport.response.first?.lng {
                self.arrivalLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                let annotation = MKPointAnnotation()
                annotation.coordinate = self.arrivalLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
                annotation.title = "Arrival"
                self.page.mapView.addAnnotation(annotation)
            } else {
                print("Error: Latitude or Longitude is nil for arrival")
            }
            showAnnotationsOnMap()
        }
    }
}


extension FlightDetailViewController: MKMapViewDelegate {
    func showAnnotationsOnMap() {
        var annotations = [MKPointAnnotation]()
        if let departureLocation = self.departureLocation, let arrivalLocation = self.arrivalLocation, let planeLocation = self.planeLocation, let direction = self.direction {
            let departureAnnotation = MKPointAnnotation()
            departureAnnotation.coordinate = departureLocation
            departureAnnotation.title = "Departure"
            annotations.append(departureAnnotation)
            
            let arrivalAnnotation = MKPointAnnotation()
            arrivalAnnotation.coordinate = arrivalLocation
            arrivalAnnotation.title = "Arrival"
            annotations.append(arrivalAnnotation)
            
            let airplane = FlightAnnotation(coordinate: planeLocation, title: "Airplane", subtitle: nil, direction: direction, flight_iata: "", dep_iata: "", arr_iata: "")
            self.page.mapView.addAnnotation(airplane)
            
            let departureToAirplaneCoordinates = [departureLocation, planeLocation]
            let departureToAirplanePolyline = MKPolyline(coordinates: departureToAirplaneCoordinates, count: departureToAirplaneCoordinates.count)
            departureToAirplanePolyline.title = "departureToAirplane"
            self.page.mapView.addOverlay(departureToAirplanePolyline)
            
            let airplaneToArrivalCoordinates = [planeLocation, arrivalLocation]
            let airplaneToArrivalPolyline = MKPolyline(coordinates: airplaneToArrivalCoordinates, count: airplaneToArrivalCoordinates.count)
            airplaneToArrivalPolyline.title = "airplaneToArrival"
            self.page.mapView.addOverlay(airplaneToArrivalPolyline)
            
            let region = regionForAnnotations(annotations, focusOnPlane: true)
            self.page.mapView.setRegion(region, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let flightAnnotation = annotation as? FlightAnnotation else { return nil }
        
        let reuseIdentifier = "flightAnnotationReuseIdentifier"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "airplane")
        annotationView?.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        let radians = flightAnnotation.direction * .pi / 180.0
        let adjustedRadians = radians - (.pi / 2)
        
        annotationView!.transform = CGAffineTransform(rotationAngle: CGFloat(adjustedRadians))
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.lineWidth = 2
            renderer.lineDashPattern = [2, 5]
            
            if overlay.title == "departureToAirplane" {
                renderer.strokeColor = .systemBlue
            } else if overlay.title == "airplaneToArrival" {
                renderer.strokeColor = .systemGray3
            }
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    private func createPolyline(_ startLocation: CLLocationCoordinate2D, _ endLocation: CLLocationCoordinate2D, _ title: String) {
        let coordinates = [startLocation, endLocation]
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        polyline.title = title
        page.mapView.addOverlay(polyline)
    }
    
    func regionForAnnotations(_ annotations: [MKAnnotation], focusOnPlane: Bool = false) -> MKCoordinateRegion {
        var region: MKCoordinateRegion = MKCoordinateRegion()
        
        if annotations.count > 0 {
            var topLeftCoord = CLLocationCoordinate2D(latitude: -90, longitude: 180)
            var bottomRightCoord = CLLocationCoordinate2D(latitude: 90, longitude: -180)
            
            for annotation in annotations {
                topLeftCoord.latitude = max(topLeftCoord.latitude, annotation.coordinate.latitude)
                topLeftCoord.longitude = min(topLeftCoord.longitude, annotation.coordinate.longitude)
                
                bottomRightCoord.latitude = min(bottomRightCoord.latitude, annotation.coordinate.latitude)
                bottomRightCoord.longitude = max(bottomRightCoord.longitude, annotation.coordinate.longitude)
            }
            
            var center = CLLocationCoordinate2D(
                latitude: topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5,
                longitude: topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5
            )
            
            if focusOnPlane, let planeLocation = annotations.first?.coordinate {
                center = planeLocation
            }
            
            let extraSpace = 1.1
            let span = MKCoordinateSpan(
                latitudeDelta: abs(topLeftCoord.latitude - bottomRightCoord.latitude) * extraSpace,
                longitudeDelta: abs(bottomRightCoord.longitude - topLeftCoord.longitude) * extraSpace
            )
            
            // Ensure that the span is not too large
            let maxSpan: CLLocationDegrees = 180.0
            let adjustedSpan = min(span.latitudeDelta, maxSpan) // Adjusted for both latitude and longitude
            
            region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: adjustedSpan, longitudeDelta: adjustedSpan))
        }
        
        return region
    }
}
