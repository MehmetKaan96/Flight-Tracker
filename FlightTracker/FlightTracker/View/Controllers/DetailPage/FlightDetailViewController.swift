//
//  FlightDetailViewController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 20.11.2023.
//

import UIKit

class FlightDetailViewController: UIViewController {

    let viewModel: FlightDetailsViewModel
    let page = CustomPage()
    var selectedIATA: String?
    var depIATA: String?
    var arrIATA: String?
    
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
            make.edges.equalToSuperview()
        }
    }
    
}

extension FlightDetailViewController: FlightDetailsViewModelDelegate {
    func fetchFlightData(_ flight: FlightInfo) {
        DispatchQueue.main.async { [self] in
            page.planeModel.text = flight.response.model
            
            page.aircraftDetail1.setInfoDetail1(with: flight.response.manufacturer ?? "Not Yet Available")
            page.aircraftDetail1.setInfoDetail2(with: flight.response.type ?? "Not Yet Available")
            page.aircraftDetail1.setInfoDetail3(with: flight.response.engine ?? "Not Yet Available")
//
            
            guard let built = flight.response.built, let age = flight.response.age else { return }
            page.aircraftDetail2.setInfoDetail1(with: "\(built)")
            page.aircraftDetail2.setInfoDetail2(with: "\(age)")
            page.aircraftDetail2.setInfoDetail3(with: flight.response.engineCount ?? "Not Yet Available")
//
            page.dateAndIataLabel.text = ((flight.response.depTime ?? "Not Yet Available") + " " + (flight.response.flightIata ?? "Not Yet Available"))
            page.departureDetail.setGate(with: flight.response.depGate ?? "Not Yet Available")
            page.departureDetail.setAirport(with: "Departure Airport Info")
            page.departureDetail.setTerminal(with: flight.response.depTerminal ?? "Not Yet Available")
            page.departureDetail.setDepartTime(with: flight.response.depActual ?? "Not Yet Available")
            

            page.arrivalDetail.setGate(with: flight.response.arrGate ?? "Not Yet Available")
            page.arrivalDetail.setAirport(with: "Arrival Airport Info")
            page.arrivalDetail.setTerminal(with: flight.response.arrTerminal ?? "Not Yet Available")
            page.arrivalDetail.setArrivalTime(with: flight.response.arrTime ?? "Not Yet Available")
            
            page.depAndArrCountry.text = ((flight.response.depCity ?? "Not Yet Available") + " to " + (flight.response.arrCity ?? "Not Yet Available"))
        }
    }
    
    func fetchDepartureAirport(_ airport: Airport) {
        DispatchQueue.main.async { [self] in
            page.departureDetail.setAirportName(using: airport.response.first?.name ?? "Not Yet Available")
        }
    }
    
    func fetchArrivalAirport(_ airport: Airport) {
        DispatchQueue.main.async { [self] in
            page.arrivalDetail.setAirportName(using: airport.response.first?.name ?? "Not Yet Available")
        }
    }
}
