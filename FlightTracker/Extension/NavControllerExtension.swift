//
//  NavControllerExtension.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 20.07.2023.
//

import UIKit

extension UINavigationController {
    func applyBackgroundGradient(colors: [UIColor], alpha: CGFloat = 1.0) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.withAlphaComponent(alpha).cgColor }
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension CAGradientLayer {
    func createGradientImage() -> UIImage? {
        UIGraphicsBeginImageContext(bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
