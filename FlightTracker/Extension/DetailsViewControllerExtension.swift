//
//  DetailsViewControllerExtension.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 24.07.2023.
//

import UIKit
import MapKit
import RxSwift
import RxCocoa

extension DetailsViewController: MKMapViewDelegate {
    private func showFlightOnMap(lat: Double, lng: Double) {
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
        flightPlaceMap.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        flightPlaceMap.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "FlightAnnotation")
        let size = CGSize(width: 30, height: 30)
        let resizedImage = UIImage(named: "airpin")?.resized(to: size)
        annotationView.image = resizedImage
        
        return annotationView
    }
}


//MARK: - Data Bindings
extension DetailsViewController {
    func setupBindings() {
        viewModel.flightInfo
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] flightInfo in
                guard let self = self, let flightInfo = flightInfo else { return }
                self.flightStatusLabel.text = flightInfo.status ?? "N/A"
                self.flightDurationLabel.text = "\(String(describing: flightInfo.duration) ?? "N/A")"
                self.aircraftICAOLabel.text = flightInfo.aircraftIcao ?? "N/A"
                self.departureCityLabel.text = flightInfo.depCity ?? "N/A"
                self.departureIATALabel.text = flightInfo.depIata ?? "N/A"
                self.arrivalCityLabel.text = flightInfo.arrCity ?? "N/A"
                self.arrivalIATALabel.text = flightInfo.arrIata ?? "N/A"
                self.arrTerminalGateLabel.text = "Terminal \(flightInfo.arrTerminal ?? "N/A") - Gate \(flightInfo.arrGate ?? "N/A")"
                self.depTerminalGateLabel.text = "Terminal \(flightInfo.arrTerminal ?? "N/A") - Gate \(flightInfo.arrGate ?? "N/A")"
                if let date = flightInfo.depTime {
                    self.dateLabel.text = "\(date)"
                }
                
                guard let lat = flightInfo.lat, let lon = flightInfo.lng else { return }
                self.showFlightOnMap(lat: lat, lng: lon)
            })
            .disposed(by: disposeBag)
        
        viewModel.flightDuration
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] duration in
                guard let self = self, let duration = duration else { return }
                let hours = duration / 60
                let minutes = duration % 60
                let delayDescription = String(format: "%d saat %d dakika", hours, minutes)
                self.flightDurationLabel.text = "\(delayDescription)"
            })
            .disposed(by: disposeBag)
    }
}
