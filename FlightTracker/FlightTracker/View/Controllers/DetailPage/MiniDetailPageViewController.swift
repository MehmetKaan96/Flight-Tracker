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
        fetchData(iata: iata, depIata: depiata, arrIata: arriata)
        
        view.addSubview(page)
        page.mapView.delegate = self
        page.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func fetchData(iata: String, depIata: String, arrIata: String) {
            viewModel.fetchFlightInfo(with: iata)
            viewModel.fetchDepartureAirport(with: depIata)
            viewModel.fetchArrivalAirport(with: arrIata)
        }
    
}
