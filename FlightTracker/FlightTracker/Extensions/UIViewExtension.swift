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
        var colorTop: CGColor
        var colorMid: CGColor
        var colorBottom: CGColor
        
        if traitCollection.userInterfaceStyle == .dark {
            // Dark Mode
            colorTop = UIColor.black.cgColor
            colorMid = UIColor.theme.cgColor
            colorBottom = UIColor.white.cgColor
        } else {
            // Light Mode
            colorTop = UIColor.white.cgColor
            colorMid = UIColor.theme.cgColor
            colorBottom = UIColor.black.cgColor
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorMid, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        
        // Remove existing gradient layers
        self.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
