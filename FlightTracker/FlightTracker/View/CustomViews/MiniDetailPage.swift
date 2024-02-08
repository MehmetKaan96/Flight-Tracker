//
//  MiniDetailPage.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 2.12.2023.
//

import UIKit
import SnapKit
import MapKit

final class MiniDetailPage: UIView {
    let flightIATALabel = UILabel()
    var mapView = MKMapView()
    let depCode = UILabel()
    let depAirport = UILabel()
    let arrCode = UILabel()
    let arrAirport = UILabel()
    let departureTime = UILabel()
    let arrivalTime = UILabel()
    let flightDuration = UILabel()
    let fullInfoButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        setGradientBackground()
        backgroundColor = .dynamicBG
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
        
        flightIATALabel.textColor = .dynamicText
        flightIATALabel.textAlignment = .center
        flightIATALabel.numberOfLines = 0
        addSubview(flightIATALabel)
        bringSubviewToFront(flightIATALabel)
        flightIATALabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(5)
        }
        
        let infoView = UIView()
        infoView.layer.borderWidth = 1
//        infoView.backgroundColor =  .dynamicBG
        infoView.layer.borderColor = UIColor.black.cgColor
        infoView.layer.cornerRadius = 10
        addSubview(infoView)
        infoView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        let fromLabel = UILabel()
        fromLabel.text = "FROM".localized()
        fromLabel.textColor = .dynamicText.withAlphaComponent(0.8)
        fromLabel.font = .systemFont(ofSize: 10, weight: .regular)
        fromLabel.textAlignment = .center
        fromLabel.numberOfLines = 0
        infoView.addSubview(fromLabel)
        fromLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(50)
        }
        
        depCode.textColor = .dynamicText
        depCode.textAlignment = .center
        depCode.font = .systemFont(ofSize: 40, weight: .semibold)
        infoView.addSubview(depCode)
        depCode.snp.makeConstraints { make in
            make.top.equalTo(fromLabel.snp.bottom).offset(10)
            make.left.equalTo(fromLabel)
        }
        
        depAirport.textColor = .dynamicText
        depAirport.font = .systemFont(ofSize: 15, weight: .regular)
        infoView.addSubview(depAirport)
        depAirport.snp.makeConstraints { make in
            make.top.equalTo(depCode.snp.bottom).offset(10)
            make.left.equalTo(depCode)
        }
        
        let departureImage = UIImageView()
        departureImage.image = UIImage(systemName: "arrow.up.right.circle.fill")
        infoView.addSubview(departureImage)
        departureImage.snp.makeConstraints { make in
            make.width.height.equalTo(25)
            make.centerY.equalTo(depCode)
            make.left.equalToSuperview().offset(15)
        }
        
        let horizonralLineView = UIView()
        horizonralLineView.backgroundColor = .systemGray
        infoView.addSubview(horizonralLineView)
        horizonralLineView.snp.makeConstraints { make in
            make.top.equalTo(departureImage.snp.bottom).offset(10)
            make.centerX.equalTo(departureImage)
            make.width.equalTo(2)
            make.height.equalTo(140)
        }
        
        let arrivalImage = UIImageView()
        arrivalImage.image = UIImage(systemName: "arrow.down.right.circle.fill")
        infoView.addSubview(arrivalImage)
        arrivalImage.snp.makeConstraints { make in
            make.width.height.equalTo(25)
            make.top.equalTo(horizonralLineView.snp.bottom).offset(10)
            make.centerX.equalTo(departureImage)
        }
        
        let toLabel = UILabel()
        toLabel.text = "TO".localized()
        toLabel.textColor = .dynamicText.withAlphaComponent(0.8)
        toLabel.font = .systemFont(ofSize: 10, weight: .regular)
        toLabel.textAlignment = .center
        toLabel.numberOfLines = 0
        infoView.addSubview(toLabel)
        toLabel.snp.makeConstraints { make in
            make.top.equalTo(horizonralLineView.snp.bottom).inset(20)
            make.left.equalTo(arrivalImage.snp.right).offset(10)
        }
        
        arrCode.textAlignment = .center
        arrCode.textColor = .dynamicText
        arrCode.font = .systemFont(ofSize: 40, weight: .semibold)
        infoView.addSubview(arrCode)
        arrCode.snp.makeConstraints { make in
            make.left.equalTo(arrivalImage.snp.right).offset(10)
            make.top.equalTo(toLabel.snp.bottom).offset(10)
        }
        
        arrAirport.textAlignment = .center
        arrAirport.textColor = .dynamicText
        arrAirport.font = .systemFont(ofSize: 15, weight: .regular)
        infoView.addSubview(arrAirport)
        arrAirport.snp.makeConstraints { make in
            make.top.equalTo(arrCode.snp.bottom).offset(10)
            make.left.equalTo(arrCode)
        }
                
        departureTime.textColor = .dynamicText
        departureTime.font = .systemFont(ofSize: 25, weight: .semibold)
        departureTime.textAlignment = .center
        departureTime.numberOfLines = 0
        infoView.addSubview(departureTime)
        departureTime.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(30)
            make.centerY.equalTo(depCode)
        }
        
        flightDuration.font = .systemFont(ofSize: 15, weight: .regular)
        flightDuration.textAlignment = .center
        flightDuration.textColor = .dynamicText
        flightDuration.numberOfLines = 0
        infoView.bringSubviewToFront(flightDuration)
        infoView.addSubview(flightDuration)
        flightDuration.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(horizonralLineView)
        }
        
        arrivalTime.font = .systemFont(ofSize: 25, weight: .semibold)
        arrivalTime.textAlignment = .center
        arrivalTime.textColor = .dynamicText
        arrivalTime.numberOfLines = 0
        infoView.addSubview(arrivalTime)
        arrivalTime.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(30)
            make.centerY.equalTo(arrCode)
        }
        
        fullInfoButton.setTitle("See Full Info".localized(), for: .normal)
        fullInfoButton.configuration = .plain()
        fullInfoButton.layer.borderWidth = 1
        fullInfoButton.layer.borderColor = UIColor.systemBlue.cgColor
        fullInfoButton.layer.cornerRadius = 10
        infoView.addSubview(fullInfoButton)
        fullInfoButton.snp.makeConstraints { make in
            make.top.equalTo(arrAirport.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(20)
        }
        


    }
}
