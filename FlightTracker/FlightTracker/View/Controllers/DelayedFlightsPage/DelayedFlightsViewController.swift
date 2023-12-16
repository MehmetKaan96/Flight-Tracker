//
//  DelayedFlightsViewController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 3.12.2023.
//

import UIKit

class DelayedFlightsViewController: UIViewController {
    
    let page = DelayedFlightPage()

    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
    }
    
    private func createUI() {
        
        view.addSubview(page)
        page.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        page.typeTextField.delegate = self
        page.timeTextField.delegate = self
        
        page.typePicker.delegate = self
        page.typePicker.dataSource = self
        
        page.delayTimePicker.delegate = self
        page.delayTimePicker.dataSource = self
        
        page.searchBar.delegate = self
    }
    
}
