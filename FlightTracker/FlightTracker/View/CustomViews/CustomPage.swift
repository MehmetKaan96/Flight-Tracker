//
//  CustomPage.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 19.11.2023.
//

import UIKit

class CustomPage: UIView {
    
    init() {
        super.init(frame: .zero)
        createUI()
        setGradientBackground()
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradientBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 15
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    private func setGradientBackground() {
        let colorTop = UIColor.gradientTop.cgColor
        let colorBottom = UIColor.theme.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.4]
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at:0)
    }
    
    
}
