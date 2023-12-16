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
            page.timeTextField.text = "\(page.duration[selectedRow]) min"
            page.timeTextField.resignFirstResponder()
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
