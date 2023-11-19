//
//  FlightsTableViewCell.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 19.11.2023.
//

import UIKit

class FlightsTableViewCell: UITableViewCell {
    
    static let identifier = "FlightsTableViewCell"
    var depIATA = UILabel()
    var arrIATA = UILabel()
    var aircraftICAO = UILabel()
    var flightIATA = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func createUI() {
        
        self.backgroundColor = .clear
        
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "ticketbg")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        contentView.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview().inset(10)
        }
        
        let planeImage = UIImageView()
        planeImage.image = UIImage(systemName: "airplane")
        backgroundImage.addSubview(planeImage)
        backgroundImage.bringSubviewToFront(planeImage)
        planeImage.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
                
        depIATA.numberOfLines = 0
        depIATA.textAlignment = .center
        backgroundImage.addSubview(depIATA)
        backgroundImage.bringSubviewToFront(depIATA)
        depIATA.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.snp.top).offset(10)
            make.left.equalTo(backgroundImage.snp.left).inset(20)
        }
        
        arrIATA.numberOfLines = 0
        arrIATA.textAlignment = .center
        backgroundImage.addSubview(arrIATA)
        backgroundImage.bringSubviewToFront(arrIATA)
        arrIATA.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.snp.top).offset(10)
            make.right.equalToSuperview().inset(20)
        }

        aircraftICAO.numberOfLines = 0
        aircraftICAO.textAlignment = .center
        backgroundImage.addSubview(aircraftICAO)
        backgroundImage.bringSubviewToFront(aircraftICAO)
        aircraftICAO.snp.makeConstraints { make in
            make.top.equalTo(depIATA.snp.bottom).offset(50)
            make.left.equalTo(backgroundImage.snp.left).inset(20)
        }

        flightIATA.numberOfLines = 0
        flightIATA.textAlignment = .center
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
        self.aircraftICAO.text = flight.aircraft_icao ?? "N/A"
        self.arrIATA.text = flight.arr_iata ?? "N/A"
        self.depIATA.text = flight.dep_iata ?? "N/A"
        self.flightIATA.text = flight.flight_iata ?? "N/A"
    }

}
