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
    
    init(viewModel: FlightDetailsViewModel, selectedIATA: String?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        self.selectedIATA = selectedIATA
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
    }
    
    private func createUI() {
        guard let iata = selectedIATA else { return }
        viewModel.fetchFlightInfo(with: iata)
        
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
            
            page.dateAndIataLabel.text = flight.response.aircraftIcao
            page.aircraftDetail1.setInfoDetail1(with: flight.response.manufacturer ?? "N/A")
            page.aircraftDetail1.setInfoDetail2(with: flight.response.type ?? "N/A")
            page.aircraftDetail1.setInfoDetail3(with: flight.response.engine ?? "N/A")
//            
            page.aircraftDetail2.setInfoDetail1(with: String(describing: flight.response.built) ?? "N/A")
            page.aircraftDetail2.setInfoDetail2(with: String(describing: flight.response.age) ?? "N/A")
            page.aircraftDetail2.setInfoDetail3(with: flight.response.engineCount ?? "N/A")
//            
            page.dateAndIataLabel.text = ((flight.response.depTime ?? "N/A") + " " + (flight.response.flightIata ?? "N/A")) ?? "N/A"
            page.departureDetail.setGate(with: flight.response.depGate ?? "N/A")
            page.departureDetail.setAirport(with: flight.response.depIata ?? "N/A")
            page.departureDetail.setTerminal(with: flight.response.depTerminal ?? "N/A")
            page.departureDetail.setDepartTime(with: flight.response.depActual ?? "N/A")
            page.departureDetail.setAirportName(using: flight.response.depCity ?? "N/A")

            page.arrivalDetail.setGate(with: flight.response.arrGate ?? "N/A")
            page.arrivalDetail.setAirport(with: flight.response.arrIata ?? "N/A")
            page.arrivalDetail.setTerminal(with: flight.response.arrTerminal ?? "N/A")
            page.arrivalDetail.setArrivalTime(with: flight.response.arrTime ?? "N/A")
            page.arrivalDetail.setAirportName(using: flight.response.arrCity ?? "N/A")
        }
    }
}
