//
//  ViewController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 17.11.2023.
//

import UIKit
import SnapKit
import MapKit

class MainViewController: UIViewController {

    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let segmentControl = UISegmentedControl()
        segmentControl.insertSegment(withTitle: "Map View", at: 0, animated: true)
        segmentControl.insertSegment(withTitle: "List View", at: 1, animated: true)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        view.addSubview(segmentControl)
        view.bringSubviewToFront(segmentControl)
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(view.frame.size.height / 15)
            make.centerX.equalToSuperview()
        }
    }

    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            //
            mapView.isHidden = false
        } else if sender.selectedSegmentIndex == 1 {
            mapView.isHidden = true
        }
    }
}

