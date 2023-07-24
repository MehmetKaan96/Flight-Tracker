//
//  MapViewController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 27.06.2023.
//

import UIKit
import MapKit
import RxSwift

class MapViewController: UIViewController {
    
    lazy var infoView: InfoView = {
        guard let view = Bundle.main.loadNibNamed("InfoView", owner: self, options: nil)?.first as? InfoView else {
            return InfoView()
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var map: MKMapView = {
        let map =  MKMapView()
        map.mapType = .satellite
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        return map
    }()
    
    var selectedFlightIata: String?
    let viewModel = FlightsListViewModel()
    let disposeBag = DisposeBag()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(map)
        view.addSubview(infoView)
        infoView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        infoView.addGestureRecognizer(panGesture)
        
        map.delegate = self
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: view.topAnchor),
            map.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            map.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            map.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            infoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
        ])
        setupBinding()
        viewModel.fetchFlights()
    }
    
}
