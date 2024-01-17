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
    let filterView = FilterView()
    
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
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            let timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { [weak self] _ in
//                self?.viewModel.fetchFlights()
//                print("çalıştı")
//            }
//            
//            RunLoop.main.add(timer, forMode: .common)
//        }
//    }
    
    private func setupUI() {
        view.backgroundColor = .white
        viewModel.fetchFlights()
        mapView.mapType = .standard
        mapView.delegate = self
        mapView.isUserInteractionEnabled = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        filterButton.setImage(.filter, for: .normal)
        view.addSubview(filterButton)
        view.bringSubviewToFront(filterButton)
        filterButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(90)
            make.right.equalToSuperview().inset(30)
        }
        filterButton.addTarget(self, action: #selector(openFilterMenu), for: .touchUpInside)
        
        
        filterView.backgroundColor = .white.withAlphaComponent(0.4)
        filterView.layer.cornerRadius = 12
        filterView.alpha = 0
        view.addSubview(filterView)
        view.bringSubviewToFront(filterView)
        filterView.snp.makeConstraints { make in
            //            make.centerX.equalTo(view)
            make.top.equalTo(filterButton.snp.bottom)
            make.right.equalTo(filterButton.snp.left)
            make.height.width.equalTo(view.snp.width).dividedBy(2)
        }
        
        filterView.scheduledButton.addTarget(self, action: #selector(scheduledTapped), for: .touchUpInside)
        filterView.enRouteButton.addTarget(self, action: #selector(enrouteTapped), for: .touchUpInside)
        filterView.landedButton.addTarget(self, action: #selector(landedTapped), for: .touchUpInside)
    }
    
    @objc func openFilterMenu() {
        
        UIView.animate(withDuration: 0.5) { [self] in
            filterView.alpha = filterView.alpha == 0 ? 1 : 0
            filterView.transform = filterView.alpha == 0 ? .identity : CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    @objc func scheduledTapped() {
        filterView.enRouteButton.isSelected = false
            filterView.enRouteButton.setImage(UIImage(named: "radiobutton"), for: .normal)
            
            filterView.landedButton.isSelected = false
            filterView.landedButton.setImage(UIImage(named: "radiobutton"), for: .normal)
            
        if !filterView.scheduledButton.isSelected {
            filterView.scheduledButton.isSelected = true
            filterView.scheduledButton.setImage(UIImage(named: "selected_radiobutton"), for: .normal)
            filterFlightsAndShowOnMap()
        } else {
            filterView.scheduledButton.setImage(UIImage(named: "radiobutton"), for: .normal)
            filterView.scheduledButton.isSelected = false
        }
        print("Tapped")
    }
    
    @objc func enrouteTapped() {
        filterView.landedButton.isSelected = false
        filterView.landedButton.setImage(UIImage(named: "radiobutton"), for: .normal)
        filterView.scheduledButton.isSelected = false
        filterView.scheduledButton.setImage(UIImage(named: "radiobutton"), for: .normal)
        if !filterView.enRouteButton.isSelected {
            filterView.enRouteButton.isSelected = true
            filterView.enRouteButton.setImage(UIImage(named: "selected_radiobutton"), for: .normal)
            filterFlightsAndShowOnMap()
        } else {
            filterView.enRouteButton.isSelected = false
            filterView.enRouteButton.setImage(UIImage(named: "radiobutton"), for: .normal)
        }
    }
    
    @objc func landedTapped() {
        filterView.enRouteButton.isSelected = false
        filterView.enRouteButton.setImage(UIImage(named: "radiobutton"), for: .normal)
        filterView.scheduledButton.isSelected = false
        filterView.scheduledButton.setImage(UIImage(named: "radiobutton"), for: .normal)
        if !filterView.landedButton.isSelected {
            filterView.landedButton.isSelected = true
            filterView.landedButton.setImage(UIImage(named: "selected_radiobutton"), for: .normal)
            filterFlightsAndShowOnMap()
        } else {
            filterView.landedButton.isSelected = false
            filterView.landedButton.setImage(UIImage(named: "radiobutton"), for: .normal)
        }
    }
}


