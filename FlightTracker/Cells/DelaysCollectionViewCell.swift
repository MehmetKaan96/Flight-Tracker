//
//  DelaysCollectionViewCell.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 22.07.2023.
//

import UIKit

class DelaysCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var IATAStack: UIStackView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var flightIATALabel: UILabel!
    @IBOutlet weak var arrIATA: UILabel!
    @IBOutlet weak var flightPathView: UIView!
    @IBOutlet weak var depIATA: UILabel!
    @IBOutlet weak var plannedTime: UILabel!
    @IBOutlet weak var estimatedTime: UILabel!
    @IBOutlet weak var delayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        IATAStack.layer.borderWidth = 1.5
        flightPathView.drawFlightPath()
        self.layer.borderWidth = 1.25
        self.layer.cornerRadius = 5
        self.setupGradientBackground(isVertical: false)
//        IATAStack.setupGradientBackground(isVertical: false)
    }
}
