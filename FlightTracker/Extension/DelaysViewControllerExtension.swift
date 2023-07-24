//
//  DelaysViewControllerExtension.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 20.07.2023.
//

import UIKit

extension DelaysViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    // MARK: UIPickerView DataSource and Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == minutePicker {
            return minutes.count
        } else {
            return flightTypes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == minutePicker {
            return "\(minutes[row])"
        } else {
            return flightTypes[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == minutePicker {
            let minutes = self.minutes[row]
            let flightType = self.flightTypes[self.flightTypePicker.selectedRow(inComponent: 0)]
            self.viewModel.fetchDelayedFlightInfos(duration: "\(minutes)", type: flightType)
        } else {
            let flightType = self.flightTypes[row]
            let minutes = self.minutes[self.minutePicker.selectedRow(inComponent: 0)]
            self.viewModel.fetchDelayedFlightInfos(duration: "\(minutes)", type: flightType)
        }
    }
}
