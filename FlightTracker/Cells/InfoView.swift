//
//  InfoView.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 11.07.2023.
//

import UIKit

protocol InfoViewDelegate: AnyObject {
    func didButtonTapped()
}

class InfoView: UIView {
    
    @IBOutlet weak var headStack: UIStackView!
    @IBOutlet weak var infoStack: UIStackView!
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var aircraftICAOLabel: UILabel!
    @IBOutlet weak var departureAirportLabel: UILabel!
    @IBOutlet weak var arrivalAirportLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var moreInfoButton: UIButton!
    
    weak var delegate: InfoViewDelegate?
    var moreInfoHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headView.layer.cornerRadius = 10
        headStack.layer.cornerRadius = 10
        infoStack.layer.borderWidth = 1
        headView.setupGradientBackground()
        infoStack.layer.cornerRadius = 10
    }
    
    @IBAction func moreInfoButtonPressed(_ sender: UIButton) {
        delegate?.didButtonTapped()
    }
}
