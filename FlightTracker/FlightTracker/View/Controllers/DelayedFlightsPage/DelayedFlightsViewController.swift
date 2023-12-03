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

        view.addSubview(page)
        page.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
