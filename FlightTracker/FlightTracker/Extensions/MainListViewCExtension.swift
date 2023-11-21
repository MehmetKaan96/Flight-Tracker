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
        let vc = FlightDetailViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.heroModalAnimationType = .pageIn(direction: .left)
        present(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


//MARK: - Searchbar Protocol

extension MainListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArray = flightsArray.filter({ flights in
            guard let status = flights.status else { return false}
            return status.lowercased().contains(searchText.lowercased())
        })
        if searchText.isEmpty {
            filteredArray.removeAll(keepingCapacity: false)
        }
        
        self.tableView.reloadData()
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
