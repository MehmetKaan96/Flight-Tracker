//
//  FlightDetailViewController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 20.11.2023.
//

import UIKit

class FlightDetailViewController: UIViewController {

    let viewModel: FlightDetailsViewModel
    let page = DetailPage()
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
        
        page.backButton.addTarget(self, action: #selector(previousPage), for: .touchUpInside)
    }
    
    @objc func previousPage() {
        self.dismiss(animated: true)
    }
    
}

extension FlightDetailViewController: FlightDetailsViewModelDelegate {
    func fetchFlightData(_ flight: FlightInfo) {
        DispatchQueue.main.async { [self] in
            setupAircraftDetails(flight.response)
            setupAirportDetails(page.departureDetail, flight.response.depGate, "Departure Airport Info", flight.response.depTerminal, flight.response.depActual)
            setupAirportDetails(page.arrivalDetail, flight.response.arrGate, "Arrival Airport Info", flight.response.arrTerminal, flight.response.arrTime)
            page.depAndArrCountry.text = "\(flight.response.depCity ?? "N/A") to \(flight.response.arrCity ?? "N/A")"
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
        }
    }
    
    func fetchArrivalAirport(_ airport: Airport) {
        DispatchQueue.main.async { [self] in
            page.arrivalDetail.setAirportName(using: airport.response.first?.name ?? "N/A")
        }
    }
}
