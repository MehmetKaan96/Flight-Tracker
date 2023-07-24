//
//  DelaysViewController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 19.07.2023.
//

import UIKit
import RxCocoa
import RxSwift

class DelaysViewController: UIViewController {
    
    @IBOutlet weak var delayedFlightsCollectionViewCell: UICollectionView!
    @IBOutlet weak var delayedLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var flightIATALabel: UILabel!
    @IBOutlet weak var flightTypePicker: UIPickerView!
    @IBOutlet weak var minutePicker: UIPickerView!
    let minutes = Array(stride(from: 60, through: 180, by: 10))
    let viewModel = FlightDelaysListViewModel()
    let disposeBag = DisposeBag()
    let flightTypes = ["departures", "arrivals"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flightTypePicker.dataSource = self
        flightTypePicker.delegate = self
        minutePicker.delegate = self
        minutePicker.dataSource = self
        setupBindings()
        setupPickerBindings()
        view.setupGradientBackground(isVertical: false)
        viewModel.fetchDelayedFlightInfos(duration: "60", type: flightTypes[0])
    }
    
    private func setupBindings() {
        viewModel.flightInfo
            .map { flights in
                return flights.sorted(by: { $0.delayed ?? 0 < $1.delayed ?? 0 })
            }
            .bind(to: delayedFlightsCollectionViewCell.rx.items(cellIdentifier: Constants.delaysCell, cellType: DelaysCollectionViewCell.self)) { (row, flight, cell) in
                if let status = flight.status, let iata = flight.flightIata, let minute = flight.delayed, let dep_iata = flight.depIata, let arr_iata = flight.arrIata,
                    let plannedTime = flight.arrTime, let estimatedTime = flight.arrEstimated {
                    cell.flightIATALabel.text = iata
                    cell.statusLabel.text = status
                    cell.depIATA.text = dep_iata
                    cell.arrIATA.text = arr_iata
                    cell.plannedTime.text = plannedTime
                    cell.estimatedTime.text = estimatedTime
                    let hours = minute / 60
                    let minutes = minute % 60
                    let delayDescription = String(format: "%d saat %d dakika ertelendi", hours, minutes)
                    cell.delayLabel.text = delayDescription
                }
            }
            .disposed(by: disposeBag)
    }
    private func setupPickerBindings() {
        flightTypePicker.rx.itemSelected
            .subscribe(onNext: { [unowned self] row, _ in
                let flightType = self.flightTypes[row]
                let minutes = self.minutes[self.minutePicker.selectedRow(inComponent: 0)]
                self.viewModel.fetchDelayedFlightInfos(duration: "\(minutes)", type: flightType)
            })
            .disposed(by: disposeBag)
    }
}
