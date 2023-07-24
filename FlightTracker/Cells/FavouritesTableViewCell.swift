//
//  FavouritesTableViewCell.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 20.07.2023.
//

import UIKit

class FavouritesTableViewCell: UITableViewCell {

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var arriata: UILabel!
    @IBOutlet weak var pathView: UIView!
    @IBOutlet weak var depiata: UILabel!
    @IBOutlet weak var aircrafticao: UILabel!
    @IBOutlet weak var flightiata: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.setupGradientBackground(isVertical: false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pathView.drawFlightPath()
    }

}
