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
    var planeLocation: CLLocationCoordinate2D?
    var direction: Double?
    
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
        page.mapView.delegate = self
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
            
            self.direction = flight.response.dir
            
            guard let planeLat = flight.response.lat, let planeLng = flight.response.lng else { return }
            planeLocation = CLLocationCoordinate2D(latitude: planeLat, longitude: planeLng)
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

extension MiniDetailPageViewController: MKMapViewDelegate {
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

        if let departureLocation = departureLocation, let arrivalLocation = arrivalLocation {
            let angle = calculateAngleBetweenPoints(departureLocation, arrivalLocation)
            annotationView?.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
        }

        return annotationView
    }

    func calculateAngleBetweenPoints(_ point1: CLLocationCoordinate2D, _ point2: CLLocationCoordinate2D) -> Double {
        let deltaY = point2.latitude - point1.latitude
        let deltaX = point2.longitude - point1.longitude
        let angle = atan2(deltaY, deltaX)
        return angle
    }
}
