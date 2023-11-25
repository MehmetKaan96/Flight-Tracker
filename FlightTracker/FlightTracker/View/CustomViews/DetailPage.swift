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

class CustomPage: UIView, UIScrollViewDelegate {
    
    let dateAndIataLabel = UILabel()
    let depAndArrCountry = UILabel()
    let arrivalDetailView = UIView()
    let aircraftDetailView = UIView()
    let departureDetailView = UIView()
    let aircraftDetail1 = CustomAircraftInfoView(info1: "Manufacturer", info2: "Type", info3: "Engine")
    let aircraftDetail2 = CustomAircraftInfoView(info1: "Built", info2: "Age", info3: "Engine Count")
    
    let departureDetail = AirportDetailView()
    let arrivalDetail = AirportDetailView()
    
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
        
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = false
        scrollView.delegate = self
        scrollView.backgroundColor = .clear
        scrollView.contentSize = CGSize(width: self.frame.size.width, height: self.frame.size.height * 2)
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dateAndIataLabel.text = "Wed, 20 OCT - SQ 705"
        dateAndIataLabel.textColor = .systemGray
        dateAndIataLabel.font = .systemFont(ofSize: 13, weight: .regular)
        dateAndIataLabel.textAlignment = .center
        dateAndIataLabel.numberOfLines = 0
        scrollView.addSubview(dateAndIataLabel)
        dateAndIataLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(10)
                make.left.equalTo(snp.left).offset(50)
        }
        
        depAndArrCountry.text = "İstanbul to Los Angeles"
        depAndArrCountry.textAlignment = .center
        depAndArrCountry.textColor = .black
        depAndArrCountry.numberOfLines = 0
        depAndArrCountry.font = .systemFont(ofSize: 15, weight: .semibold)
        scrollView.addSubview(depAndArrCountry)
        depAndArrCountry.snp.makeConstraints { make in
            make.top.equalTo(dateAndIataLabel.snp.bottom).offset(10)
            make.left.equalTo(dateAndIataLabel.snp.left)
        }
        
        aircraftDetailView.backgroundColor = .white
        aircraftDetailView.layer.cornerRadius = 15
        scrollView.addSubview(aircraftDetailView)
        aircraftDetailView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width).inset(10)
                make.centerX.equalTo(scrollView)
            make.height.equalTo(scrollView.snp.height).multipliedBy(0.55)
                make.top.equalTo(depAndArrCountry).offset(30)
        }
        
        departureDetailView.backgroundColor = .white
        departureDetailView.layer.cornerRadius = 15
        scrollView.addSubview(departureDetailView)
        departureDetailView.snp.makeConstraints { make in
            make.top.equalTo(aircraftDetailView.snp.bottom).offset(20)
            make.width.equalTo(scrollView.snp.width).inset(10)
            make.height.equalTo(scrollView.snp.height).multipliedBy(0.5)
            make.centerX.equalTo(scrollView)
        }
        
        
        arrivalDetailView.backgroundColor = .white
        arrivalDetailView.layer.cornerRadius = 15
        scrollView.addSubview(arrivalDetailView)
        arrivalDetailView.snp.makeConstraints { make in
            make.top.equalTo(departureDetailView.snp.bottom).offset(20)
            make.width.equalTo(scrollView.snp.width).inset(10)
            make.height.equalTo(scrollView.snp.height).multipliedBy(0.5)
            make.bottom.equalTo(scrollView.snp.bottom).inset(20)
            make.centerX.equalTo(scrollView)
        }
        
        let planeModel = UILabel()
        planeModel.text = "Airbus A350-900"
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
        aircraftDetail1.setInfoDetail1(with: "Airbus")
        aircraftDetail1.setInfoDetail2(with: "Turboshaft")
        aircraftDetail1.setInfoDetail3(with: "Landplane")
        
        
        aircraftDetailView.addSubview(aircraftDetail2)
        aircraftDetail2.snp.makeConstraints { make in
            make.top.equalTo(aircraftDetail1.snp.bottom).offset(10)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(aircraftDetailView.snp.height).multipliedBy(0.25)
            make.bottom.equalTo(aircraftDetailView.snp.bottom)
        }
        
        aircraftDetail2.setInfoDetail1(with: "2015")
        aircraftDetail2.setInfoDetail2(with: "6")
        aircraftDetail2.setInfoDetail3(with: "2")
        
        
        departureDetail.setGate(with: "D")
        departureDetail.setAirport(with: "Departure Airport Info")
        departureDetail.setTerminal(with: "96")
        departureDetail.setDepartTime(with: "18:00 UTC")
        departureDetail.setAirportName(using: "İstanbul Airport")
        departureDetailView.addSubview(departureDetail)
        departureDetail.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        arrivalDetail.setGate(with: "M")
        arrivalDetail.setAirport(with: "Arrival Airport Info")
        arrivalDetail.setTerminal(with: "20")
        arrivalDetail.setArrivalTime(with: "23:00 UTC")
        arrivalDetail.setAirportName(using: "Los Angeles International Airport")
        arrivalDetailView.addSubview(arrivalDetail)
        arrivalDetail.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    func addShadow(to view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.6
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 7
    }
    
}

#Preview() {
    CustomPage()
}
