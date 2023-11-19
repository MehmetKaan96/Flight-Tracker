//
//  UIViewExtension.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 19.11.2023.
//

import Foundation
import UIKit

extension UIView {
    func setGradientBackground() {
        let colorTop = UIColor.gradientTop.cgColor
        let colorBottom = UIColor.theme.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.4]
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}
