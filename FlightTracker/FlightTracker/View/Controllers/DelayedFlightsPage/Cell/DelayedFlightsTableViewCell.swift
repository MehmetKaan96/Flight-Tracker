//
//  DelayedFlightsTableViewCell.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 16.12.2023.
//

import UIKit

final class DelayedFlightsTableViewCell: UITableViewCell {
    
    static let identifier = "DelayedFlightsTableViewCell"
    private let depIATA = UILabel()
    private let arrIATA = UILabel()
    private let aircraftICAO = UILabel()
    private let flightIATA = UILabel()
    private let statusLabel = UILabel()
    
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
        
        self.backgroundColor = .dynamicBG
        
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "ticketbg")?.withTintColor(.dynamicBG)
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

        aircraftICAO.text = "şalkdşad"
        aircraftICAO.numberOfLines = 0
        aircraftICAO.textAlignment = .center
        aircraftICAO.textColor = .dynamicText
        backgroundImage.addSubview(aircraftICAO)
        backgroundImage.bringSubviewToFront(aircraftICAO)
        aircraftICAO.snp.makeConstraints { make in
            make.top.equalTo(depIATA.snp.bottom).offset(50)
            make.left.equalTo(backgroundImage.snp.left).inset(20)
        }

        flightIATA.text = "kjaldkaşkdsa"
        flightIATA.numberOfLines = 0
        flightIATA.textAlignment = .center
        flightIATA.textColor = .dynamicText
        backgroundImage.addSubview(flightIATA)
        backgroundImage.bringSubviewToFront(flightIATA)
        flightIATA.snp.makeConstraints { make in
            make.top.equalTo(arrIATA.snp.bottom).offset(50)
            make.right.equalToSuperview().inset(20)
        }
        
    }
    
    func configure(flight: DelayResponse) {
        self.statusLabel.text = flight.status ?? "N/A"
        self.aircraftICAO.text = flight.aircraftIcao ?? "N/A"
        self.arrIATA.text = flight.arrIata ?? "N/A"
        self.depIATA.text = flight.depIata ?? "N/A"
        self.flightIATA.text = flight.flightIata ?? "N/A"
    }

}
