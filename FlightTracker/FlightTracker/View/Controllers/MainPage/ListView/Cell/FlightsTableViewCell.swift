//
//  FlightsTableViewCell.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 19.11.2023.
//

import UIKit
import SnapKit
import Hero

class FlightsTableViewCell: UITableViewCell {
    
    static let identifier = "FlightsTableViewCell"
    var depIATA = UILabel()
    var arrIATA = UILabel()
    var aircraftICAO = UILabel()
    var flightIATA = UILabel()
    var statusLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.isHeroEnabled = true
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isHeroEnabled = true
        createUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func createUI() {
        
        self.backgroundColor = .dynamicBG
        
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "ticketbg")?.withTintColor(.dynamicBG, renderingMode: .alwaysOriginal)
        backgroundImage.layer.shadowColor = UIColor.dynamicText.cgColor
        backgroundImage.layer.shadowOpacity = 0.7
        backgroundImage.layer.shadowRadius = 0.9
        backgroundImage.layer.shadowOffset = CGSize(width: 0.7, height: 0.7)
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        contentView.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview().inset(10)
        }
        
        let planeImage = UIImageView()
        planeImage.isHeroEnabled = true
        planeImage.heroID = "plane"
        planeImage.image = UIImage(named: "miniplane")
        backgroundImage.addSubview(planeImage)
        backgroundImage.bringSubviewToFront(planeImage)
        planeImage.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(50)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
                
        depIATA.numberOfLines = 0
        depIATA.textAlignment = .center
        depIATA.textColor = .dynamicText
        backgroundImage.addSubview(depIATA)
        backgroundImage.bringSubviewToFront(depIATA)
        depIATA.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.snp.top).offset(10)
            make.left.equalTo(backgroundImage.snp.left).inset(20)
        }
        
        arrIATA.numberOfLines = 0
        arrIATA.textAlignment = .center
        arrIATA.textColor = .dynamicText
        backgroundImage.addSubview(arrIATA)
        backgroundImage.bringSubviewToFront(arrIATA)
        arrIATA.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.snp.top).offset(10)
            make.right.equalToSuperview().inset(20)
        }
        
        statusLabel.numberOfLines = 0
        statusLabel.textAlignment = .center
        statusLabel.textColor = .dynamicText
        backgroundImage.addSubview(statusLabel)
        backgroundImage.bringSubviewToFront(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.left.equalTo(depIATA.snp.right).offset(30)
            make.right.equalTo(arrIATA.snp.left).offset(-30)
            make.top.equalTo(backgroundImage.snp.top).offset(10)
        }

        aircraftICAO.numberOfLines = 0
        aircraftICAO.textAlignment = .center
        aircraftICAO.textColor = .dynamicText
        backgroundImage.addSubview(aircraftICAO)
        backgroundImage.bringSubviewToFront(aircraftICAO)
        aircraftICAO.snp.makeConstraints { make in
            make.top.equalTo(depIATA.snp.bottom).offset(50)
            make.left.equalTo(backgroundImage.snp.left).inset(20)
        }

        flightIATA.numberOfLines = 0
        flightIATA.textAlignment = .center
        flightIATA.textColor = .dynamicText
        backgroundImage.addSubview(flightIATA)
        backgroundImage.bringSubviewToFront(flightIATA)
        flightIATA.snp.makeConstraints { make in
            make.top.equalTo(arrIATA.snp.bottom).offset(50)
            make.right.equalToSuperview().inset(20)
        }
        
        let roadView = UIView()
        roadView.backgroundColor = .theme
        backgroundImage.addSubview(roadView)
        backgroundImage.bringSubviewToFront(roadView)
        roadView.snp.makeConstraints { make in
            make.top.equalTo(planeImage.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(backgroundImage.snp.width).multipliedBy(0.3)
            make.height.equalTo(2)
        }
        
    }
    
    func configure(flight: Flights) {
        self.statusLabel.text = flight.status ?? "N/A"
        self.aircraftICAO.text = flight.aircraft_icao ?? "N/A"
        self.arrIATA.text = flight.arr_iata ?? "N/A"
        self.depIATA.text = flight.dep_iata ?? "N/A"
        self.flightIATA.text = flight.flight_iata ?? "N/A"
    }

}
