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
            make.width.equalTo(scrollView.snp.width).inset(20)
            make.centerX.equalTo(scrollView)
            make.height.equalTo((UIScreen.main.bounds.height * 2) / 4.5)
            make.top.equalTo(depAndArrCountry).offset(30)
        }
        
        departureDetailView.backgroundColor = .white
        departureDetailView.layer.cornerRadius = 15
        scrollView.addSubview(departureDetailView)
        departureDetailView.snp.makeConstraints { make in
            make.top.equalTo(aircraftDetailView.snp.bottom).offset(20)
            make.width.equalTo(scrollView.snp.width).inset(20)
            make.height.equalTo((UIScreen.main.bounds.height * 2) / 4)
            make.centerX.equalTo(scrollView)
        }
        
        
        arrivalDetailView.backgroundColor = .green
        arrivalDetailView.layer.cornerRadius = 15
        scrollView.addSubview(arrivalDetailView)
        arrivalDetailView.snp.makeConstraints { make in
            make.top.equalTo(departureDetailView.snp.bottom).offset(20)
            make.width.equalTo(scrollView.snp.width).inset(20)
            make.height.equalTo((UIScreen.main.bounds.height * 2) / 4)
            make.bottom.equalTo(scrollView.snp.bottom).inset(20)
            make.centerX.equalTo(scrollView)
        }
        
        let planeModel = UILabel()
        planeModel.text = "Airbus A350-900"
        planeModel.textAlignment = .center
        planeModel.numberOfLines = 0
        planeModel.font = .systemFont(ofSize: 18, weight: .semibold)
        aircraftDetailView.addSubview(planeModel)
        planeModel.snp.makeConstraints { make in
            make.top.equalTo(aircraftDetailView.snp.top).offset(25)
            make.left.equalTo(aircraftDetailView.snp.left).offset(15)
        }
        
        let planeImage = UIImageView()
        planeImage.isHeroEnabled = true
        planeImage.heroID = "plane"
        planeImage.image = UIImage(named: "plane")
        planeImage.contentMode = .scaleAspectFill
        planeImage.clipsToBounds = true
        aircraftDetailView.addSubview(planeImage)
        planeImage.snp.makeConstraints { make in
            make.top.equalTo(planeModel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(5)
        }
        
        aircraftDetailView.addSubview(aircraftDetail1)
        aircraftDetail1.snp.makeConstraints { make in
            make.top.equalTo(planeImage.snp.bottom).offset(10)
            make.centerX.equalTo(aircraftDetailView.snp.centerX)
        }
        aircraftDetail1.setInfoDetail1(with: "Airbus")
        aircraftDetail1.setInfoDetail2(with: "Turboshaft")
        aircraftDetail1.setInfoDetail3(with: "Landplane")
        
        
        aircraftDetailView.addSubview(aircraftDetail2)
        aircraftDetail2.snp.makeConstraints { make in
            make.top.equalTo(aircraftDetail1.snp.bottom).offset(90)
            make.centerX.equalTo(aircraftDetailView.snp.centerX)
        }
        
        aircraftDetail2.setInfoDetail1(with: "2015")
        aircraftDetail2.setInfoDetail2(with: "6")
        aircraftDetail2.setInfoDetail3(with: "2")

    }
    
}


#Preview() {
    CustomPage()
}
