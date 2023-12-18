//
//  MainListViewCExtension.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 19.11.2023.
//

import Foundation
import UIKit


//MARK: - TableView Protocols
extension MainListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.isEmpty ? flightsArray.count : filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlightsTableViewCell.identifier, for: indexPath) as! FlightsTableViewCell
        if filteredArray.isEmpty {
            cell.configure(flight: flightsArray[indexPath.row])
        } else {
            cell.configure(flight: filteredArray[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let service: FlightDataService = APIManager()
        let viewModel = FlightDetailsViewModel(service: service)
        
        if filteredArray.isEmpty {
            let vc = FlightDetailViewController(viewModel: viewModel, selectedIATA: flightsArray[indexPath.row].flight_iata, dep_iata: flightsArray[indexPath.row].dep_iata, arr_iata: flightsArray[indexPath.row].arr_iata)
            vc.hero.isEnabled = true
            vc.heroModalAnimationType = .selectBy(presenting: .zoom, dismissing: .zoomOut)
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        } else {
            let vc = FlightDetailViewController(viewModel: viewModel, selectedIATA: filteredArray[indexPath.row].flight_iata, dep_iata: filteredArray[indexPath.row].dep_iata, arr_iata: filteredArray[indexPath.row].arr_iata)
            vc.hero.isEnabled = true
            vc.heroModalAnimationType = .selectBy(presenting: .pageIn(direction: .right), dismissing: .pageOut(direction: .left))
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


//MARK: - Searchbar Protocol

extension MainListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArray = flightsArray.filter { flights in
            let searchableFields = [
                flights.status,
                flights.flight_iata,
                flights.dep_iata,
                flights.arr_iata
            ]
            
            let matches = searchableFields.compactMap { $0?.lowercased().contains(searchText.lowercased()) }
            return matches.contains(true)
        }
        
        if searchText.isEmpty {
            filteredArray.removeAll(keepingCapacity: false)
            searchBar.resignFirstResponder()
        }
        
        tableView.reloadData()
    }
}


//MARK: - Flight Data Protocol
extension MainListViewController: RealtimeFlightsViewModelDelegate {
    func fetchFlights(_ flights: [Flights]) {
        DispatchQueue.main.async {
            //            flightsArray = flights
            self.tableView.reloadData()
            //            print("List VC\(flightsArray.count)")
        }
    }
}
