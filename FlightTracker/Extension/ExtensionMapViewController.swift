//
//  ExtensionMapViewController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 29.06.2023.
//

import UIKit
import MapKit
import RxSwift

//MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? FlightAnnotation else { return }
        let flight = annotation.flight
        
        if let aircraftIcao = flight.aircraftIcao {
            infoView.aircraftICAOLabel.text = "Aircraft ICAO: \(aircraftIcao)"
        } else {
            infoView.aircraftICAOLabel.text = "N/A"
        }
        infoView.departureAirportLabel.text = flight.depIata
        infoView.arrivalAirportLabel.text = flight.arrIata
        infoView.latitudeLabel.text = "\(flight.lat)"
        infoView.longitudeLabel.text = "\(flight.lng)"
        selectedFlightIata = flight.flightIata
        
        
        infoView.isHidden = false
        infoView.transform = .identity
        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "airplane"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = annotation
        }
        
        if let flightAnnotation = annotation as? FlightAnnotation {
            if let flightDirectionInDegrees = flightAnnotation.flight.dir {
                let radians = degreesToRadians(degrees: Double(flightDirectionInDegrees))
                let image = getAirplaneImage(for: radians)
                annotationView?.image = image
            } else {
                annotationView?.image = UIImage(named: "airpin")
            }
        } else {
            annotationView?.image = UIImage(named: "airpin")
        }
        
        return annotationView
    }
    
    private func degreesToRadians(degrees: Double) -> Double {
        return degrees * .pi / 180.0
    }
    
    private func getAirplaneImage(for direction: Double) -> UIImage? {
        let degrees = direction * 180.0 / .pi
        let rotatedImage = UIImage(named: "airpin")?.rotate(radians: CGFloat(degrees))
        return rotatedImage
    }
}

// MARK: - APICalls and Binding
extension MapViewController {
    func setupBinding() {
        viewModel.flights
            .observe(on: MainScheduler.instance)
            .map({ flight in
                flight.filter { $0.flightIata != nil && $0.depIata != nil && $0.arrIata != nil }
            }).subscribe { [weak self] flights in
                self?.updateMapAnnotations(flights: flights)
            }.disposed(by: disposeBag)
    }
    
    private func updateMapAnnotations(flights: [Flights]) {
        map.removeAnnotations(map.annotations)
        
        for flight in flights {
            let annotation = FlightAnnotation(flight: flight)
            map.addAnnotation(annotation)
        }
    }
    
    
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let velocity = recognizer.velocity(in: view)
        
        switch recognizer.state {
        case .began, .changed:
            infoView.transform = CGAffineTransform(translationX: 0, y: max(0, translation.y))
        case .ended:
            if velocity.y >= 1500 || translation.y >= infoView.frame.height * 0.5 {
                dismissView()
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.infoView.transform = .identity
                }
            }
        default:
            break
        }
    }
    func dismissView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.infoView.transform = CGAffineTransform(translationX: 0, y: self.infoView.frame.height)
        }) { _ in
            self.infoView.isHidden = true
            self.infoView.transform = .identity
        }
    }
    
}

//MARK: - InfoViewDelegate

extension MapViewController: InfoViewDelegate {
    func didButtonTapped() {
        if let flightIata = selectedFlightIata {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            let flightInfoVM = FlightInfoViewModel()
            flightInfoVM.fetchFlightInfo(flightIata: flightIata)
            detailVC.viewModel = flightInfoVM
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.last {
            let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
            map.setRegion(region, animated: true)
        }
    }
}
