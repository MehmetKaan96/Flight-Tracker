//
//  SearchCollectionViewCell.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 22.07.2023.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var arrView: UIView!
    @IBOutlet weak var depView: UIView!
    @IBOutlet weak var arrIATA: UILabel!
    @IBOutlet weak var depIATA: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var flightIATA: UILabel!
    @IBOutlet weak var headStack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1.5
        headStack.setupGradientBackground(isVertical: false)
        self.setupGradientBackground(isVertical: false)
        addShadows()
    }
    
    private func addShadows() {
        depView.layer.cornerRadius = 10
        arrView.layer.cornerRadius = 10
        
        depView.layer.shadowColor = UIColor.black.cgColor
        depView.layer.shadowOffset = CGSize(width: 0, height: 2)
        depView.layer.shadowOpacity = 0.5
        depView.layer.shadowRadius = 4
        
        arrView.layer.shadowColor = UIColor.black.cgColor
        arrView.layer.shadowOffset = CGSize(width: 0, height: 2)
        arrView.layer.shadowOpacity = 0.5
        arrView.layer.shadowRadius = 4
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4
    }
}
