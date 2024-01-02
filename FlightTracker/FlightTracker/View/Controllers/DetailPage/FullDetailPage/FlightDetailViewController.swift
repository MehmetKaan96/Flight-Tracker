//
//  FlightDetailViewController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 20.11.2023.
//

import UIKit
import MapKit

class FlightDetailViewController: UIViewController {
    
    let viewModel: FlightDetailsViewModel
    let page = DetailPage()
    var selectedIATA: String?
    var depIATA: String?
    var arrIATA: String?
    var departureLocation: CLLocationCoordinate2D?
    var arrivalLocation: CLLocationCoordinate2D?
    var planeLocation: CLLocationCoordinate2D?
    var direction: Double?
    var flightInfo: RealmFlightInfo!
    
    internal var flightDataFetched = false
    internal var departureAirportFetched = false
    internal var arrivalAirportFetched = false
    
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
        
        createUI()
    }
    
    private func createUI() {
        guard let iata = selectedIATA, let depiata = depIATA, let arriata = arrIATA else { return }
        viewModel.fetchFlightInfo(with: iata)
        viewModel.fetchDepartureAirport(with: depiata)
        viewModel.fetchArrivalAirport(with: arriata)
        self.isHeroEnabled = true
        view.addSubview(page)
        page.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
        
        page.mapView.delegate = self
        page.mapView.showsUserLocation = true
        page.backButton.addTarget(self, action: #selector(previousPage), for: .touchUpInside)
        
        page.favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func favouriteButtonTapped() {
        if page.favouriteButton.isSelected {
            page.favouriteButton.setImage(UIImage(named: "heart"), for: .normal)

        } else {
            page.favouriteButton.setImage(UIImage(named: "heart.fill"), for: .normal)
            print(flightInfo.status)
            print(flightInfo.arrCity)
            print(flightInfo.depCity)
            print(flightInfo.flightIata)
            print(flightInfo.arrTime)
            print(flightInfo.depTime)
        }
        page.favouriteButton.isSelected.toggle()
    }
    
    @objc func previousPage() {
        self.dismiss(animated: true)
    }
    
    func allDataFetched() -> Bool {
        return flightDataFetched && departureAirportFetched && arrivalAirportFetched
    }
    
    func resetFetchFlags() {
        flightDataFetched = false
        departureAirportFetched = false
        arrivalAirportFetched = false
    }
    
}
