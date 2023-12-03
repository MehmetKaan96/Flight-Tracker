//
//  MiniDetailPage.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 2.12.2023.
//

import UIKit
import SnapKit
import MapKit

class MiniDetailPage: UIView {
    let flightIATALabel = UILabel()
    lazy var mapView = MKMapView()
    let depCode = UILabel()
    let depCity = UILabel()
    let arrCode = UILabel()
    let arrCity = UILabel()
    let departureTime = UILabel()
    let arrivalTime = UILabel()
    let flightDuration = UILabel()
    
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
        mapView.mapType = .standard
        mapView.isScrollEnabled = true
        mapView.isZoomEnabled = true
        addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(snp.height).dividedBy(2.5)
        }
        
        flightIATALabel.textColor = .black.withAlphaComponent(0.6)
        flightIATALabel.textAlignment = .center
        flightIATALabel.numberOfLines = 0
        addSubview(flightIATALabel)
        bringSubviewToFront(flightIATALabel)
        flightIATALabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(5)
        }
        
        let infoView = UIView()
        infoView.backgroundColor = .white
        addSubview(infoView)
        infoView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        let fromLabel = UILabel()
        fromLabel.text = "FROM"
        fromLabel.textColor = .black.withAlphaComponent(0.8)
        fromLabel.font = .systemFont(ofSize: 10, weight: .regular)
        fromLabel.textAlignment = .center
        fromLabel.numberOfLines = 0
        infoView.addSubview(fromLabel)
        fromLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(40)
        }
        
        depCode.textAlignment = .center
        depCode.font = .systemFont(ofSize: 40, weight: .semibold)
        infoView.addSubview(depCode)
        depCode.snp.makeConstraints { make in
            make.top.equalTo(fromLabel.snp.bottom)
            make.left.equalTo(fromLabel)
        }
        
        depCity.font = .systemFont(ofSize: 15, weight: .regular)
        infoView.addSubview(depCity)
        depCity.snp.makeConstraints { make in
            make.top.equalTo(depCode.snp.bottom)
            make.left.equalTo(depCode)
        }
        
        let toLabel = UILabel()
        toLabel.text = "TO"
        toLabel.textColor = .black.withAlphaComponent(0.8)
        toLabel.font = .systemFont(ofSize: 10, weight: .regular)
        toLabel.textAlignment = .center
        toLabel.numberOfLines = 0
        infoView.addSubview(toLabel)
        toLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(40)
        }
        
        arrCode.textAlignment = .center
        arrCode.font = .systemFont(ofSize: 40, weight: .semibold)
        infoView.addSubview(arrCode)
        arrCode.snp.makeConstraints { make in
            make.top.equalTo(toLabel.snp.bottom)
            make.right.equalTo(toLabel)
        }
        
        arrCity.textAlignment = .center
        arrCity.font = .systemFont(ofSize: 15, weight: .regular)
        infoView.addSubview(arrCity)
        arrCity.snp.makeConstraints { make in
            make.top.equalTo(arrCode.snp.bottom)
            make.right.equalTo(arrCode)
        }
        
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 110
        infoView.addSubview(horizontalStack)
        horizontalStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(arrCity.snp.bottom).offset(40)
        }
        
        let departureImage = UIImageView()
        departureImage.image = UIImage(named: "departure")
        horizontalStack.addArrangedSubview(departureImage)
        departureImage.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        
        let clockImage = UIImageView()
        clockImage.image = UIImage(named: "clock")
        horizontalStack.addArrangedSubview(clockImage)
        clockImage.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        
        let arrivalImage = UIImageView()
        arrivalImage.image = UIImage(named: "arrival")
        horizontalStack.addArrangedSubview(arrivalImage)
        arrivalImage.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        
        departureTime.font = .systemFont(ofSize: 15, weight: .bold)
        departureTime.textAlignment = .center
        departureTime.numberOfLines = 0
        infoView.addSubview(departureTime)
        departureTime.snp.makeConstraints { make in
            make.top.equalTo(horizontalStack.snp.bottom).offset(15)
            make.left.equalTo(departureImage).offset(-15)
        }
        
        flightDuration.font = .systemFont(ofSize: 15, weight: .bold)
        flightDuration.textAlignment = .center
        flightDuration.numberOfLines = 0
        infoView.addSubview(flightDuration)
        flightDuration.snp.makeConstraints { make in
            make.top.equalTo(horizontalStack.snp.bottom).offset(15)
            make.centerX.equalTo(clockImage)
        }
        
        arrivalTime.font = .systemFont(ofSize: 15, weight: .bold)
        arrivalTime.textAlignment = .center
        arrivalTime.numberOfLines = 0
        infoView.addSubview(arrivalTime)
        arrivalTime.snp.makeConstraints { make in
            make.top.equalTo(horizontalStack.snp.bottom).offset(15)
            make.right.equalTo(arrivalImage).offset(15)
        }
    }
}
