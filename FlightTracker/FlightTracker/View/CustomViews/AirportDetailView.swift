//
//  AirportDetailView.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 21.11.2023.
//

import Foundation
import UIKit
import SnapKit

class AirportDetailView: UIView {
    
    let airportName = UILabel()
    let flightTimeText = UILabel()
    let terminalText = UILabel()
    let gateText = UILabel()
    let airportInfoLabel = UILabel()
    let arrivalTime = UILabel()
    
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
        
        airportInfoLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        airportInfoLabel.numberOfLines = 0
        addSubview(airportInfoLabel)
        airportInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(20)
            make.left.equalTo(snp.left).offset(10)
            make.right.equalTo(snp.right).offset(-100)
        }
        
        let nameStack = UIStackView()
        nameStack.axis = .horizontal
        nameStack.spacing = 10
        nameStack.distribution = .fillEqually
        addSubview(nameStack)
        nameStack.snp.makeConstraints { make in
            make.top.equalTo(airportInfoLabel.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(10)
        }
        
        let airportNameLabel = UILabel()
        airportNameLabel.text = "Airport Name:"
        airportNameLabel.font = .systemFont(ofSize: 18, weight: .medium)
        nameStack.addArrangedSubview(airportNameLabel)
        
        airportName.numberOfLines = 0
        airportName.font = .systemFont(ofSize: 16, weight: .regular)
        nameStack.addArrangedSubview(airportName)
        
        let timeStack = UIStackView()
        timeStack.axis = .horizontal
        timeStack.spacing = 10
        timeStack.distribution = .fillEqually
        addSubview(timeStack)
        timeStack.snp.makeConstraints { make in
            make.top.equalTo(nameStack.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(10)
        }
        
        let flightTime = UILabel()
        flightTime.text = "Time:"
        flightTime.font = .systemFont(ofSize: 18, weight: .medium)
        timeStack.addArrangedSubview(flightTime)
        
        flightTimeText.font = .systemFont(ofSize: 16, weight: .regular)
        flightTimeText.numberOfLines = 0
        timeStack.addArrangedSubview(flightTimeText)
        
        let terminalStack = UIStackView()
        terminalStack.axis = .horizontal
        terminalStack.spacing = 10
        terminalStack.distribution = .fillEqually
        addSubview(terminalStack)
        terminalStack.snp.makeConstraints { make in
            make.top.equalTo(timeStack.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(10)
        }
        
        let terminalLabel = UILabel()
        terminalLabel.text = "Terminal:"
        terminalLabel.font = .systemFont(ofSize: 18, weight: .medium)
        terminalStack.addArrangedSubview(terminalLabel)
        
        terminalText.font = .systemFont(ofSize: 16, weight: .regular)
        terminalText.numberOfLines = 0
        terminalStack.addArrangedSubview(terminalText)
        
        let gateStack = UIStackView()
        gateStack.axis = .horizontal
        gateStack.spacing = 10
        gateStack.distribution = .fillEqually
        addSubview(gateStack)
        gateStack.snp.makeConstraints { make in
            make.top.equalTo(terminalStack.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(10)
        }
        
        let gateLabel = UILabel()
        gateLabel.text = "Gate:"
        gateLabel.font = .systemFont(ofSize: 18, weight: .medium)
        gateStack.addArrangedSubview(gateLabel)
        
        gateText.font = .systemFont(ofSize: 16, weight: .regular)
        gateText.numberOfLines = 0
        gateStack.addArrangedSubview(gateText)
        
        
        let fullInfoStack = UIStackView()
        fullInfoStack.axis = .vertical
        addSubview(fullInfoStack)
        fullInfoStack.distribution = .fillEqually
        fullInfoStack.addArrangedSubview(nameStack)
        fullInfoStack.addArrangedSubview(timeStack)
        fullInfoStack.addArrangedSubview(terminalStack)
        fullInfoStack.addArrangedSubview(gateStack)
        fullInfoStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
    
    func setAirportName(using name: String) {
        airportName.text = name
    }
    
    func setDepartTime(with time: String) {
        flightTimeText.text = time
    }
    
    func setTerminal(with terminal: String) {
        terminalText.text = terminal
    }
    
    func setGate(with gate: String) {
        gateText.text = gate
    }
    
    func setAirport(with text: String) {
        airportInfoLabel.text = text
    }
    
    func setArrivalTime(with text: String) {
        flightTimeText.text = text
    }
    
}
