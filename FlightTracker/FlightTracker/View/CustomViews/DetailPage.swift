//
//  DetailPage.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 20.11.2023.
//

import Foundation
import UIKit
import SnapKit
import Hero
import MapKit

class DetailPage: UIView, UIScrollViewDelegate {
    let dateAndIataLabel = UILabel()
    let depAndArrCountry = UILabel()
    let arrivalDetailView = UIView()
    let aircraftDetailView = UIView()
    let departureDetailView = UIView()
    let aircraftDetail1 = CustomAircraftInfoView(info1: "Manufacturer", info2: "Type", info3: "Engine")
    let aircraftDetail2 = CustomAircraftInfoView(info1: "Built", info2: "Age", info3: "Engine Count")
    let planeModel = UILabel()
    let departureDetail = AirportDetailView()
    let arrivalDetail = AirportDetailView()
    let backButton = UIButton()
    let scrollView = UIScrollView()
    let mapView = MKMapView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradientBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        
        scrollView.isPagingEnabled = false
        scrollView.delegate = self
        scrollView.backgroundColor = .clear
        scrollView.contentSize = CGSize(width: self.frame.size.width, height: self.frame.size.height * 2)
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        scrollView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(20)
            make.left.equalTo(scrollView.snp.left).offset(15)
        }
        
        dateAndIataLabel.textColor = .systemGray
        dateAndIataLabel.font = .systemFont(ofSize: 13, weight: .regular)
        dateAndIataLabel.textAlignment = .center
        dateAndIataLabel.numberOfLines = 0
        scrollView.addSubview(dateAndIataLabel)
        dateAndIataLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(10)
            make.left.equalTo(backButton.snp.left).offset(30)
        }
        
        depAndArrCountry.textAlignment = .center
        depAndArrCountry.textColor = .black
        depAndArrCountry.numberOfLines = 0
        depAndArrCountry.font = .systemFont(ofSize: 15, weight: .semibold)
        scrollView.addSubview(depAndArrCountry)
        depAndArrCountry.snp.makeConstraints { make in
            make.top.equalTo(dateAndIataLabel.snp.bottom).offset(10)
            make.left.equalTo(dateAndIataLabel.snp.left)
        }
        
        mapView.isScrollEnabled = true
        mapView.mapType = .standard
        mapView.layer.cornerRadius = 20
        scrollView.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.equalTo(depAndArrCountry.snp.bottom).offset(20)
            make.width.equalTo(scrollView.snp.width).inset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(scrollView.snp.height).multipliedBy(0.4)
        }
        
        aircraftDetailView.backgroundColor = .white
        aircraftDetailView.layer.cornerRadius = 15
        scrollView.addSubview(aircraftDetailView)
        aircraftDetailView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width).inset(10)
                make.centerX.equalTo(scrollView)
            make.top.equalTo(mapView.snp.bottom).offset(30)
        }
        
        departureDetailView.backgroundColor = .white
        departureDetailView.layer.cornerRadius = 15
        scrollView.addSubview(departureDetailView)
        departureDetailView.snp.makeConstraints { make in
            make.top.equalTo(aircraftDetailView.snp.bottom).offset(20)
            make.width.equalTo(scrollView.snp.width).inset(10)
            make.centerX.equalTo(scrollView)
        }
        
        
        arrivalDetailView.backgroundColor = .white
        arrivalDetailView.layer.cornerRadius = 15
        scrollView.addSubview(arrivalDetailView)
        arrivalDetailView.snp.makeConstraints { make in
            make.top.equalTo(departureDetailView.snp.bottom).offset(20)
            make.width.equalTo(scrollView.snp.width).inset(10)
            make.bottom.equalTo(scrollView.snp.bottom).inset(20)
            make.centerX.equalTo(scrollView)
        }
        
        
        planeModel.textAlignment = .left
        planeModel.textColor = .black
        planeModel.numberOfLines = 0
        planeModel.font = .systemFont(ofSize: 18, weight: .semibold)
        aircraftDetailView.addSubview(planeModel)
        planeModel.snp.makeConstraints { make in
            make.top.equalTo(aircraftDetailView.snp.top)
            make.left.equalTo(aircraftDetailView.snp.left).offset(15)
            make.right.equalTo(aircraftDetailView.snp.right)
        }
        
        let planeImage = UIImageView()
        planeImage.isHeroEnabled = true
        planeImage.heroID = "plane"
        planeImage.image = UIImage(named: "plane")
        planeImage.contentMode = .scaleAspectFill
        planeImage.clipsToBounds = true
        aircraftDetailView.addSubview(planeImage)
        planeImage.snp.makeConstraints { make in
            make.top.equalTo(planeModel.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        aircraftDetailView.addSubview(aircraftDetail1)
        aircraftDetail1.snp.makeConstraints { make in
            make.top.equalTo(planeImage.snp.bottom)
            make.centerX.equalTo(snp.centerX)
                make.height.equalTo(aircraftDetailView.snp.height).multipliedBy(0.2)
        }

        aircraftDetailView.addSubview(aircraftDetail2)
        aircraftDetail2.snp.makeConstraints { make in
            make.top.equalTo(aircraftDetail1.snp.bottom).offset(10)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(aircraftDetailView.snp.height).multipliedBy(0.25)
            make.bottom.equalTo(aircraftDetailView.snp.bottom)
        }

        departureDetailView.addSubview(departureDetail)
        departureDetail.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        arrivalDetailView.addSubview(arrivalDetail)
        arrivalDetail.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
                
        self.layoutIfNeeded()
        
    }
    
    func addShadow(to view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.6
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 7
    }
}
