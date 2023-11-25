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
        
        airportInfoLabel.textColor = .black
        airportInfoLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        airportInfoLabel.numberOfLines = 0
        addSubview(airportInfoLabel)
        airportInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(20)
            make.left.equalTo(snp.left).offset(20)
            make.right.equalTo(snp.right).offset(-100)
            make.height.equalTo(snp.height).dividedBy(10)
        }
        
        let nameStack = UIStackView()
        nameStack.axis = .horizontal
        nameStack.spacing = 10
        nameStack.distribution = .fillEqually
        
        let airportNameLabel = UILabel()
        airportNameLabel.text = "Airport Name:"
        airportNameLabel.textColor = .systemGray
        airportNameLabel.font = .systemFont(ofSize: 18, weight: .medium)
        airportName.numberOfLines = 0
        airportName.font = .systemFont(ofSize: 16, weight: .regular)
        airportName.textColor = .black
        nameStack.addArrangedSubview(airportNameLabel)
        nameStack.addArrangedSubview(airportName)
        
        let timeStack = UIStackView()
        timeStack.axis = .horizontal
        timeStack.spacing = 10
        timeStack.distribution = .fillEqually
        
        let flightTime = UILabel()
        flightTime.text = "Time:"
        flightTime.textColor = .systemGray
        flightTime.font = .systemFont(ofSize: 18, weight: .medium)
        flightTimeText.font = .systemFont(ofSize: 16, weight: .regular)
        flightTimeText.numberOfLines = 0
        flightTimeText.textColor = .black
        timeStack.addArrangedSubview(flightTime)
        timeStack.addArrangedSubview(flightTimeText)
        
        let terminalStack = UIStackView()
        terminalStack.axis = .horizontal
        terminalStack.spacing = 10
        terminalStack.distribution = .fillEqually
        
        let terminalLabel = UILabel()
        terminalLabel.text = "Terminal:"
        terminalLabel.font = .systemFont(ofSize: 18, weight: .medium)
        terminalLabel.textColor = .systemGray
        terminalText.font = .systemFont(ofSize: 16, weight: .regular)
        terminalText.numberOfLines = 0
        terminalText.textColor = .black
        terminalStack.addArrangedSubview(terminalLabel)
        terminalStack.addArrangedSubview(terminalText)
        
        let gateStack = UIStackView()
        gateStack.axis = .horizontal
        gateStack.spacing = 10
        gateStack.distribution = .fillEqually
        
        let gateLabel = UILabel()
        gateLabel.text = "Gate:"
        gateLabel.textColor = .systemGray
        gateLabel.font = .systemFont(ofSize: 18, weight: .medium)
        gateText.font = .systemFont(ofSize: 16, weight: .regular)
        gateText.numberOfLines = 0
        gateText.textColor = .black
        gateStack.addArrangedSubview(gateLabel)
        gateStack.addArrangedSubview(gateText)
        
        
        let fullInfoStack = UIStackView()
        fullInfoStack.axis = .vertical
        addSubview(fullInfoStack)
        fullInfoStack.distribution = .fillProportionally
        fullInfoStack.addArrangedSubview(nameStack)
        fullInfoStack.addArrangedSubview(timeStack)
        fullInfoStack.addArrangedSubview(terminalStack)
        fullInfoStack.addArrangedSubview(gateStack)
        fullInfoStack.snp.makeConstraints { make in
            make.top.equalTo(airportInfoLabel.snp.bottom).offset(10)
            make.left.equalTo(snp.left).offset(20)
            make.right.equalTo(snp.right).inset(20)
            make.bottom.equalTo(snp.bottom).inset(10)
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
