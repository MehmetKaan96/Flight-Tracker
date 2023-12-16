//
//  ViewController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 17.11.2023.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation

class MainViewController: UIViewController {

    let viewModel: RealtimeFlightsViewModel
    lazy var mapView = MKMapView()
    let filterButton = UIButton()
    
    init(viewModel: RealtimeFlightsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        viewModel.fetchFlights()
        mapView.mapType = .standard
        mapView.delegate = self
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        filterButton.setImage(UIImage(named: "filter"), for: .normal)
        if #available(iOS 15.0, *) {
            filterButton.configuration = .plain()
        } else {
            // Fallback on earlier versions
        }
        filterButton.backgroundColor = .clear
        filterButton.imageView?.clipsToBounds = true
        view.addSubview(filterButton)
        filterButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(view.frame.size.height / 15)
            make.right.equalTo(view.snp.right).inset(20)
        }
    }
}


