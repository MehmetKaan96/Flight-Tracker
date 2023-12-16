//
//  DelayedFlightsViewControllerExtension.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 16.12.2023.
//

import Foundation
import UIKit

extension DelayedFlightsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == page.typePicker {
            return page.type.count
        } else if pickerView == page.delayTimePicker {
            return page.duration.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == page.typePicker {
            return page.type[row]
        } else if pickerView == page.delayTimePicker {
            return "\(page.duration[row]) min"
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == page.typePicker {
            let selectedRow = page.typePicker.selectedRow(inComponent: 0)
            page.typeTextField.text = page.type[selectedRow]
            page.typeTextField.resignFirstResponder()
        } else if pickerView == page.delayTimePicker {
            let selectedRow = page.delayTimePicker.selectedRow(inComponent: 0)
            page.timeTextField.text = "\(page.duration[selectedRow])"
            page.timeTextField.resignFirstResponder()
        }
        
        if let type = page.typeTextField.text, let minute = page.timeTextField.text,!type.isEmpty, !minute.isEmpty {
            viewModel.getDelayedFlights(with: type, and: minute)
        }
    }
}

extension DelayedFlightsViewController: UITextFieldDelegate {
    
}

extension DelayedFlightsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //TODO: Write search action
    }
}

extension DelayedFlightsViewController: DelayedFlightViewModelDelegate {
    func getDelayedFlights(_ flights: [DelayResponse]) {
        DispatchQueue.main.async { [self] in
            delayedFlightArray = flights.compactMap { flight in
                guard flight.aircraftIcao != nil,
                      flight.airlineIata != nil,
                      flight.arrDelayed != nil,
                      flight.arrIata != nil,
                      flight.delayed != nil,
                      flight.depDelayed != nil,
                      flight.depIata != nil,
                      flight.duration != nil,
                      flight.flightIata != nil,
                      flight.status != nil else { return nil }
                
                return flight
            }
            page.delayedTableView.reloadData()
        }
    }
}

extension DelayedFlightsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delayedFlightArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DelayedFlightsTableViewCell.identifier, for: indexPath) as! DelayedFlightsTableViewCell
        
        cell.configure(flight: delayedFlightArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let service: FlightDataService = APIManager()
        let viewModel = FlightDetailsViewModel(service: service)
        
        let vc = FlightDetailViewController(viewModel: viewModel, selectedIATA: delayedFlightArray[indexPath.row].flightIata, dep_iata: delayedFlightArray[indexPath.row].depIata, arr_iata: delayedFlightArray[indexPath.row].arrIata)
        present(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
