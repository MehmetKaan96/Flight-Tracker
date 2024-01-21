//
//  FilterView.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 15.01.2024.
//

import Foundation
import UIKit

final class FilterView: UIView {
   let scheduledButton = UIButton()
   let enRouteButton = UIButton()
   let landedButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createUI() {
        let scheduledStack = UIStackView()
        scheduledStack.axis = .horizontal
        scheduledStack.distribution = .fill
        scheduledStack.spacing = 5

        scheduledButton.setImage(UIImage(named: "radiobutton"), for: .normal)

        let scheduledLabel = UILabel()
        scheduledLabel.text = "Scheduled"
        scheduledLabel.textColor = .dynamicText
        scheduledLabel.textAlignment = .left
        scheduledLabel.numberOfLines = 0

        scheduledStack.addArrangedSubview(scheduledButton)
        scheduledStack.addArrangedSubview(scheduledLabel)

        addSubview(scheduledStack)

        scheduledStack.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalToSuperview().dividedBy(4)
        }
        
        let enrouteStack = UIStackView()
        enrouteStack.axis = .horizontal
        enrouteStack.distribution = .fill
        enrouteStack.spacing = 5
        enRouteButton.setImage(UIImage(named: "radiobutton"), for: .normal)
        
        let enrouteLabel = UILabel()
        enrouteLabel.text = "En-Route"
        enrouteLabel.textColor = .dynamicText
        enrouteLabel.textAlignment = .left
        enrouteLabel.numberOfLines = 0
        
        enrouteStack.addArrangedSubview(enRouteButton)
        enrouteStack.addArrangedSubview(enrouteLabel)
        
        addSubview(enrouteStack)
        
        enrouteStack.snp.makeConstraints { make in
            make.top.equalTo(scheduledStack.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalToSuperview().dividedBy(4)
        }
        
        let landedStack = UIStackView()
        landedStack.axis = .horizontal
        landedStack.distribution = .fill
        landedStack.spacing = 5
        landedButton.setImage(UIImage(named: "radiobutton"), for: .normal)
        
        let landedLabel = UILabel()
        landedLabel.text = "Landed"
        landedLabel.textColor = .dynamicText
        landedLabel.textAlignment = .left
        landedLabel.numberOfLines = 0
        
        landedStack.addArrangedSubview(landedButton)
        landedStack.addArrangedSubview(landedLabel)
        
        addSubview(landedStack)
        
        landedStack.snp.makeConstraints { make in
            make.top.equalTo(enrouteStack.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalToSuperview().dividedBy(4)
        }
    }
}
