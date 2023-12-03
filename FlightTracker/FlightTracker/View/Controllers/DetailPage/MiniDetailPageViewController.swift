//
//  MiniDetailPageViewController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 2.12.2023.
//

import UIKit
import CoreLocation
import MapKit

class MiniDetailPageViewController: UIViewController {
    
    let viewModel: FlightDetailsViewModel
    var selectedIATA: String?
    var depIATA: String?
    var arrIATA: String?
    var departureLocation: CLLocationCoordinate2D?
    var arrivalLocation: CLLocationCoordinate2D?
    let page = MiniDetailPage()
    
    init(viewModel: FlightDetailsViewModel, selectedIATA: String?, dep_iata: String?, arr_iata: String?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        self.selectedIATA = selectedIATA
        self.depIATA = dep_iata
        self.arrIATA = arr_iata
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createUI()
    }
    
    private func createUI() {
        guard let iata = selectedIATA, let depiata = depIATA, let arriata = arrIATA else { return }
        viewModel.fetchFlightInfo(with: iata)
        viewModel.fetchDepartureAirport(with: depiata)
        viewModel.fetchArrivalAirport(with: arriata)
        
        view.addSubview(page)
        page.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension MiniDetailPageViewController: FlightDetailsViewModelDelegate {
    func fetchFlightData(_ flight: FlightInfo) {
        DispatchQueue.main.async { [self] in
            page.flightIATALabel.text = flight.response.flightIata ?? "N/A"
            page.arrCity.text = flight.response.arrCity ?? "N/A"
            page.depCity.text = flight.response.depCity ?? "N/A"
            page.arrCode.text = flight.response.arrIata ?? "N/A"
            page.depCode.text = flight.response.depIata ?? "N/A"
            
            guard let arrTime = flight.response.arrTime, let depTime = flight.response.depTime, let duration = flight.response.duration else { return }
            
            let formattetArrTime = arrTime.formatDateTimeToTime()
            let formattedDepTime = depTime.formatDateTimeToTime()
            let formattedDuration = duration.convertDuration()
            
            page.arrivalTime.text = formattetArrTime
            page.departureTime.text = formattedDepTime
            page.flightDuration.text = formattedDuration
            
            
        }
    }
    
    func fetchDepartureAirport(_ airport: Airport) {
        DispatchQueue.main.async { [weak self] in
            if let lat = airport.response.first?.lat, let lng = airport.response.first?.lng {
                self?.departureLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                let annotation = MKPointAnnotation()
                annotation.coordinate = self?.departureLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
                annotation.title = "Departure"
                self?.page.mapView.addAnnotation(annotation)
                self?.showAnnotationsOnMap()
            } else {
                print("Error: Latitude or longitude is nil.")
            }
        }
    }

    func fetchArrivalAirport(_ airport: Airport) {
        DispatchQueue.main.async { [weak self] in
            if let lat = airport.response.first?.lat, let lng = airport.response.first?.lng {
                self?.arrivalLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                let annotation = MKPointAnnotation()
                annotation.coordinate = self?.arrivalLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
                annotation.title = "Arrival"
                self?.page.mapView.addAnnotation(annotation)
                self?.showAnnotationsOnMap()
            } else {
                print("Error: Latitude or longitude is nil.")
            }
        }
    }
    
    func showAnnotationsOnMap() {
            var annotations = [MKPointAnnotation]()
            if let departureLocation = self.departureLocation, let arrivalLocation = self.arrivalLocation {
                let departureAnnotation = MKPointAnnotation()
                departureAnnotation.coordinate = departureLocation
                departureAnnotation.title = "Departure"
                annotations.append(departureAnnotation)

                let arrivalAnnotation = MKPointAnnotation()
                arrivalAnnotation.coordinate = arrivalLocation
                arrivalAnnotation.title = "Arrival"
                annotations.append(arrivalAnnotation)
            }
            let region = regionForAnnotations(annotations)
            self.page.mapView.setRegion(region, animated: true)
        }
        
    func regionForAnnotations(_ annotations: [MKAnnotation]) -> MKCoordinateRegion {
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

            let center = CLLocationCoordinate2D(
                latitude: topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5,
                longitude: topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5
            )

            let extraSpace = 1.1
            let span = MKCoordinateSpan(
                latitudeDelta: abs(topLeftCoord.latitude - bottomRightCoord.latitude) * extraSpace,
                longitudeDelta: abs(bottomRightCoord.longitude - topLeftCoord.longitude) * extraSpace
            )

            region = MKCoordinateRegion(center: center, span: span)
        }

        return region
    }
}
