//
//  AirportDetailView.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 21.11.2023.
//

import Foundation
import UIKit
import SnapKit

final class AirportDetailView: UIView {
    
   private let airportName = UILabel()
   private let flightTimeText = UILabel()
   private let terminalText = UILabel()
   private let gateText = UILabel()
   private let airportInfoLabel = UILabel()
   private let arrivalTime = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 1
        layer.borderColor = UIColor.theme.cgColor
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        
        let airportLabel = UILabel()
        airportLabel.textColor = .dynamicText
        airportLabel.font = .systemFont(ofSize: 23, weight: .bold)
        airportLabel.text = "Detailed Info".localized()
        addSubview(airportLabel)
        airportLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().offset(10)
            make.height.equalTo(snp.height).dividedBy(10)
        }
        
        let airportSubLabel = UILabel()
        airportSubLabel.text = "Name, Time, Terminal, Gate".localized()
        airportSubLabel.textColor = .systemGray2
        addSubview(airportSubLabel)
        airportSubLabel.snp.makeConstraints { make in
            make.top.equalTo(airportLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().offset(10)
            make.height.equalTo(snp.height).dividedBy(10)
        }
        
        airportInfoLabel.textColor = .dynamicText
        airportInfoLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        airportInfoLabel.numberOfLines = 0
        addSubview(airportInfoLabel)
        airportInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(airportSubLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(snp.height).dividedBy(10)
        }
        
        let nameStack = UIStackView()
        nameStack.axis = .horizontal
        nameStack.distribution = .fillEqually
        
        let airportNameLabel = UILabel()
        airportNameLabel.text = "Airport Name:".localized()
        airportNameLabel.textColor = .systemGray
        airportNameLabel.font = .systemFont(ofSize: 18, weight: .medium)
        airportName.numberOfLines = 0
        airportName.font = .systemFont(ofSize: 16, weight: .regular)
        airportName.textColor = .dynamicText
        nameStack.addArrangedSubview(airportNameLabel)
        nameStack.addArrangedSubview(airportName)
        nameStack.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        let timeStack = UIStackView()
        timeStack.axis = .horizontal
        timeStack.distribution = .fillEqually
        
        let flightTime = UILabel()
        flightTime.text = "Time:".localized()
        flightTime.textColor = .systemGray
        flightTime.font = .systemFont(ofSize: 18, weight: .medium)
        flightTimeText.font = .systemFont(ofSize: 16, weight: .regular)
        flightTimeText.numberOfLines = 0
        flightTimeText.textColor = .dynamicText
        timeStack.addArrangedSubview(flightTime)
        timeStack.addArrangedSubview(flightTimeText)
        timeStack.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        let terminalStack = UIStackView()
        terminalStack.axis = .horizontal
        terminalStack.distribution = .fillEqually
        
        let terminalLabel = UILabel()
        terminalLabel.text = "Terminal:".localized()
        terminalLabel.font = .systemFont(ofSize: 18, weight: .medium)
        terminalLabel.textColor = .systemGray
        terminalText.font = .systemFont(ofSize: 16, weight: .regular)
        terminalText.numberOfLines = 0
        terminalText.textColor = .dynamicText
        terminalStack.addArrangedSubview(terminalLabel)
        terminalStack.addArrangedSubview(terminalText)
        terminalStack.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        let gateStack = UIStackView()
        gateStack.axis = .horizontal
        gateStack.distribution = .fillEqually
        
        let gateLabel = UILabel()
        gateLabel.text = "Gate:".localized()
        gateLabel.textColor = .systemGray
        gateLabel.font = .systemFont(ofSize: 18, weight: .medium)
        gateText.font = .systemFont(ofSize: 16, weight: .regular)
        gateText.numberOfLines = 0
        gateText.textColor = .dynamicText
        gateStack.addArrangedSubview(gateLabel)
        gateStack.addArrangedSubview(gateText)
        gateStack.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        let fullInfoStack = UIStackView()
        fullInfoStack.axis = .vertical
        fullInfoStack.spacing = 15
        addSubview(fullInfoStack)
        fullInfoStack.addArrangedSubview(nameStack)
        fullInfoStack.addArrangedSubview(timeStack)
        fullInfoStack.addArrangedSubview(terminalStack)
        fullInfoStack.addArrangedSubview(gateStack)
        fullInfoStack.snp.makeConstraints { make in
            make.top.equalTo(airportInfoLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview().inset(10)
        }
        
    }
    
    func setAirportName(using name: String?) {
        airportName.text = name ?? "N/A"
    }
    
    func setDepartTime(with time: String?) {
        flightTimeText.text = time?.formatDateTimeToTime() ?? "N/A"
    }
    
    func setTerminal(with terminal: String?) {
        terminalText.text = terminal ?? "N/A"
    }
    
    func setGate(with gate: String?) {
        gateText.text = gate ?? "N/A"
    }
    
    func setAirport(with text: String?) {
        airportInfoLabel.text = text ?? "N/A"
    }
    
    func setArrivalTime(with text: String?) {
        flightTimeText.text = text ?? "N/A"
    }
    
}
