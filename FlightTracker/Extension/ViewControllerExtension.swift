//
//  ViewControllerExtension.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 28.06.2023.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

// MARK: - APICall and Binding

extension ViewController {
    func setupTableView() {
        flightsListCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func bindViewModelToCollectionView() {
        viewModel.flights
            .map { flights in
                flights.filter { $0.flightIata != nil && $0.depIata != nil && $0.arrIata != nil }
            }
            .bind(to: flightsListCollectionView.rx.items(cellIdentifier: Constants.cellId, cellType: FlightsCollectionViewCell.self)) { [weak self] row, flight, cell in
                guard self != nil else { return }
                guard let flight_iata = flight.flightIata,
                      let dep_iata = flight.depIata,
                      let arr_iata = flight.arrIata,
                      let aircraft_icao = flight.aircraftIcao,
                      let status = flight.status,
                let reg_number = flight.regNumber else { return }
                cell.flightIATALabel.text = flight_iata
                cell.depIATALabel.text = dep_iata
                cell.arrIATALabel.text = arr_iata
                cell.aircraftICAOLabel.text = aircraft_icao
                cell.statusLabel.text = status
                cell.regNumber.text = reg_number
                cell.layer.borderWidth = 1
                
                let flightForRealm = FavouriteFlights()
                flightForRealm.flightIata = flight.flightIata
                flightForRealm.depIata = flight.depIata
                flightForRealm.arrIata = flight.arrIata
                flightForRealm.status = flight.status
                flightForRealm.aircraftIcao = flight.aircraftIcao
                
                cell.flight = flightForRealm
            }
            .disposed(by: disposeBag)
    }
    
    func segmentControlObservable() {
        segmentedControl.rx.selectedSegmentIndex.asObservable()
            .subscribe { [self] index in
                if index == 1 {
                    let navController = UINavigationController(rootViewController: mapViewController)
                    addChild(navController)
                    self.mapView.isHidden = false
                    self.formView.isHidden = true
                    navController.view.frame = self.mapView.bounds
                    self.mapView.addSubview(navController.view)
                    self.mapViewController.view.frame = self.mapView.bounds
                    self.mapViewController.didMove(toParent: self)
                    self.navigationController?.setNavigationBarHidden(true, animated: true)
                } else {
                    self.mapView.isHidden = true
                    self.formView.isHidden = false
                    self.navigationController?.setNavigationBarHidden(false, animated: true)
                    self.mapViewController.view.removeFromSuperview()
                }
            }.disposed(by: disposeBag)
    }
}

//MARK: - TableViewDelegate

extension ViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueIdentifier {
            if let selectedIndexPath = flightsListCollectionView.indexPathsForSelectedItems?.first {
                let selectedRow = selectedIndexPath.row
                let flight = viewModel.flights.value[selectedRow]
                if let flightIata = flight.flightIata {
                    if let detailVC = segue.destination as? DetailsViewController {
                        let flightInfoVM = FlightInfoViewModel()
                        flightInfoVM.fetchFlightInfo(flightIata: flightIata)
                        detailVC.viewModel = flightInfoVM
                    }
                }
            }
        }
    }
}
