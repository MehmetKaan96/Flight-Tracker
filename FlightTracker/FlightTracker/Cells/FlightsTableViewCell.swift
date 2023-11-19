//
//  FlightsTableViewCell.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 19.11.2023.
//

import UIKit

class FlightsTableViewCell: UITableViewCell {
    
    static let identifier = "FlightsTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func createUI() {
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "ticketbg")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        contentView.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        let planeImage = UIImageView()
        planeImage.image = UIImage(named: "plane")?.withHorizontallyFlippedOrientation()
        backgroundImage.addSubview(planeImage)
        backgroundImage.bringSubviewToFront(planeImage)
        planeImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(50)
        }
        
        let depIATA = UILabel()
        depIATA.text = "DepIATA"
        depIATA.numberOfLines = 0
        depIATA.textAlignment = .center
        backgroundImage.addSubview(depIATA)
        backgroundImage.bringSubviewToFront(depIATA)
        depIATA.snp.makeConstraints { make in
            make.left.equalTo(planeImage.snp.right)
        }
        
        
    }

}

#Preview() {
    FlightsTableViewCell()
}
