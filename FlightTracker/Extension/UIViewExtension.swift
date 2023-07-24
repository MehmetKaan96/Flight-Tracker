//
//  UIViewExtension.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 28.06.2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    func drawFlightPath(blueWidthPercentage: CGFloat = 0.8) {
            let blueShapeLayer = CAShapeLayer()
            blueShapeLayer.strokeColor = UIColor.systemBlue.cgColor
            blueShapeLayer.lineWidth = 2
            blueShapeLayer.lineDashPattern = [5, 5]
            
            let whiteShapeLayer = CAShapeLayer()
            whiteShapeLayer.strokeColor = UIColor.white.cgColor
            whiteShapeLayer.lineWidth = 2
            whiteShapeLayer.lineDashPattern = [5, 5]
            
            let path = UIBezierPath()
            let totalWidth = bounds.width
            let blueWidth = totalWidth * blueWidthPercentage
            let whiteWidth = totalWidth - blueWidth
            
            path.move(to: CGPoint(x: bounds.origin.x, y: bounds.midY))
            path.addLine(to: CGPoint(x: blueWidth, y: bounds.midY))
            
            blueShapeLayer.path = path.cgPath
            layer.addSublayer(blueShapeLayer)
            
            path.removeAllPoints()
            path.move(to: CGPoint(x: blueWidth, y: bounds.midY))
            path.addLine(to: CGPoint(x: bounds.size.width, y: bounds.midY))
            
            whiteShapeLayer.path = path.cgPath
            layer.addSublayer(whiteShapeLayer)
        }
    
    func setupGradientBackground(isVertical: Bool = true, alpha: CGFloat = 0.7, colors: [UIColor]? = nil) {
        var gradientColors: [CGColor] = []
        
        if let customColors = colors {
            for color in customColors {
                gradientColors.append(color.withAlphaComponent(alpha).cgColor)
            }
        } else {
            let blueColor = UIColor.systemBlue.withAlphaComponent(alpha)
            let whiteColor = UIColor.white.withAlphaComponent(alpha)
            gradientColors = [blueColor.cgColor, whiteColor.cgColor]
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        
        if isVertical {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        } else {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = bounds
        
        if let oldGradientLayer = layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            oldGradientLayer.removeFromSuperlayer()
        }
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
