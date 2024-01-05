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
    let filterView = UIView()
    
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
        mapView.isUserInteractionEnabled = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
//        filterButton.setImage(.filter, for: .normal)
//        view.addSubview(filterButton)
//        view.bringSubviewToFront(filterButton)
//        filterButton.snp.makeConstraints { make in
//            make.top.equalTo(view.snp.top).offset(90)
//            make.right.equalToSuperview().inset(30)
//        }
//        filterButton.addTarget(self, action: #selector(openFilterMenu), for: .touchUpInside)
        
        
//        filterView.backgroundColor = .red
//        //        filterView.isHidden = true
//        filterView.alpha = 0
//        view.addSubview(filterView)
//        view.bringSubviewToFront(filterView)
//        filterView.snp.makeConstraints { make in
//            //            make.centerX.equalTo(view)
//            make.top.equalTo(filterButton.snp.bottom)
//            make.right.equalTo(filterButton.snp.left)
//            make.height.width.equalTo(view.snp.width).dividedBy(2)
//        }
        
    }
    
//    @objc func openFilterMenu() {
//        
//        UIView.animate(withDuration: 0.5) { [self] in
//            filterView.alpha = filterView.alpha == 0 ? 1 : 0
//            filterView.transform = filterView.alpha == 0 ? .identity : CGAffineTransform(scaleX: 1.0, y: 1.0)
//        }
//    }
}


