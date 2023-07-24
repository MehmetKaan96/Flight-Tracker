//
//  OnboardCollectionViewCell.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 19.07.2023.
//

import UIKit

class OnboardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var subText: UILabel!
    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var onboardImageView: UIImageView!
    
    func configure(with page: OnboardingPage) {
        onboardImageView.image = page.image
        mainText.text = page.mainText
        subText.text = page.subText
    }
    
}
