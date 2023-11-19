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
    let listView = MainListViewController()
    
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
        let segmentControl = UISegmentedControl()
        segmentControl.insertSegment(withTitle: "Map View", at: 0, animated: true)
        segmentControl.insertSegment(withTitle: "List View", at: 1, animated: true)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        view.addSubview(segmentControl)
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(view.frame.size.height / 10.5)
            make.centerX.equalToSuperview()
        }
        
        filterButton.setImage(UIImage(named: "filter"), for: .normal)
        filterButton.configuration = .plain()
        filterButton.backgroundColor = .clear
        filterButton.imageView?.clipsToBounds = true
        view.addSubview(filterButton)
        filterButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(view.frame.size.height / 15)
            make.right.equalTo(view.snp.right).inset(20)
            make.centerY.equalTo(segmentControl.snp.centerY)
        }
        
        listView.view.isHidden = true
        view.addSubview(listView.view)
        listView.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.bringSubviewToFront(segmentControl)
    }

    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.mapView.isHidden = false
                self.listView.view.isHidden = true
            }
        } else if sender.selectedSegmentIndex == 1 {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.mapView.isHidden = true
                self.listView.view.isHidden = false
            }
        }
    }
}

