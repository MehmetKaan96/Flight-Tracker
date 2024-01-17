//
//  FavoritesTableViewCell.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 16.01.2024.
//

import UIKit

final class FavoritesTableViewCell: UITableViewCell {
    
    static let identifier = "FavoritesTableViewCell"
    
    var statusImageView = UIImageView()
    var statusLabel = UILabel()
    var flightIata = UILabel()
    var depIata = UILabel()
    var arrIata = UILabel()
    var flightCity = UILabel()
    var depTime = UILabel()
    var arrTime = UILabel()
    var estimatedDepTime = UILabel()
    var estimatedArrTime = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func createUI() {
        statusImageView.contentMode = .scaleAspectFill
        contentView.addSubview(statusImageView)
        statusImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(25)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(contentView.snp.width).dividedBy(6)
        }
        
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0
        statusLabel.textColor = .dynamicText
        statusLabel.font = .systemFont(ofSize: 15, weight: .regular)
        contentView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(statusImageView.snp.bottom).offset(5)
            make.centerX.equalTo(statusImageView)
        }
        
        flightIata.textAlignment = .left
        flightIata.numberOfLines = 0
        flightIata.textColor = .dynamicText
        flightIata.font = .systemFont(ofSize: 15, weight: .regular)
        contentView.addSubview(flightIata)
        flightIata.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.left.equalTo(statusImageView.snp.right).offset(25)
        }
        
        flightCity.textAlignment = .left
        flightCity.numberOfLines = 0
        flightCity.textColor = .dynamicText
        flightCity.font = .systemFont(ofSize: 18, weight: .bold)
        contentView.addSubview(flightCity)
        flightCity.snp.makeConstraints { make in
            make.top.equalTo(flightIata.snp.bottom).offset(10)
            make.left.equalTo(flightIata)
        }
        
        let depImage = UIImageView()
        depImage.image = UIImage(systemName: "arrow.up.right.circle.fill")
        depImage.contentMode = .scaleAspectFit
        contentView.addSubview(depImage)
        depImage.snp.makeConstraints { make in
            make.top.equalTo(flightCity.snp.bottom).offset(10)
            make.left.equalTo(flightCity)
        }
        
        depIata.textColor = .dynamicText
        depIata.textAlignment = .center
        depIata.numberOfLines = 0
        depIata.font = .systemFont(ofSize: 12, weight: .regular)
        contentView.addSubview(depIata)
        depIata.snp.makeConstraints { make in
            make.centerY.equalTo(depImage)
            make.left.equalTo(depImage.snp.right).offset(3)
        }
        
        depTime.textAlignment = .center
        depTime.numberOfLines = 0
        depTime.font = .systemFont(ofSize: 12, weight: .regular)
        contentView.addSubview(depTime)
        depTime.snp.makeConstraints { make in
            make.centerY.equalTo(depImage)
            make.left.equalTo(depIata.snp.right).offset(3)
        }
        
        let arrImage = UIImageView()
        arrImage.image = UIImage(systemName: "arrow.down.right.circle.fill")
        arrImage.contentMode = .scaleAspectFit
        contentView.addSubview(arrImage)
        arrImage.snp.makeConstraints { make in
            make.top.equalTo(flightCity.snp.bottom).offset(10)
            make.centerX.equalTo(flightCity).offset(5)
            make.left.equalTo(depTime.snp.right).offset(20)
        }
        
        arrIata.textColor = .dynamicText
        arrIata.textAlignment = .center
        arrIata.numberOfLines = 0
        arrIata.font = .systemFont(ofSize: 12, weight: .regular)
        contentView.addSubview(arrIata)
        arrIata.snp.makeConstraints { make in
            make.centerY.equalTo(arrImage)
            make.left.equalTo(arrImage.snp.right).offset(3)
        }
        
        arrTime.textAlignment = .center
        arrTime.numberOfLines = 0
        arrTime.font = .systemFont(ofSize: 12, weight: .regular)
        contentView.addSubview(arrTime)
        arrTime.snp.makeConstraints { make in
            make.centerY.equalTo(arrImage)
            make.left.equalTo(arrIata.snp.right).offset(3)
        }
        
    }
    
    internal func configure(with info: RealmFlightInfo) {
        guard let arrIata = info.arrIata, let arrTime = info.arrTime, let depIata = info.depIata, let depTime = info.depTime, let arrEstimated = info.arrEstimated, let depEstimated = info.depEstimated, let depCity = info.depCity, let arrCity = info.arrCity, let flightIata = info.flightIata, let status = info.status else { return }
        self.arrIata.text = arrIata
        self.arrTime.text = arrTime.formatDateTimeToTime()
        self.depIata.text = depIata
        self.depTime.text = depTime.formatDateTimeToTime()
        self.estimatedArrTime.text = info.arrEstimated
        self.estimatedDepTime.text = info.depEstimated
        self.flightCity.text = "\(depCity) to \(arrCity)"
        self.flightIata.text = flightIata
        
        switch status {
        case "en-route":
            self.statusImageView.image = UIImage(systemName: "arrow.up.right.circle.fill")
            self.statusLabel.text = status
        case "landed":
            self.statusImageView.image = UIImage(systemName: "arrow.down.right.circle.fill")
            self.statusLabel.text = status
        case "scheduled":
            self.statusImageView.image = UIImage(systemName: "airplane.circle.fill")
            self.statusLabel.text = status
        default:
            self.statusImageView.image = UIImage(systemName: "airplane.circle.fill")
            self.statusLabel.text = status
        }
    }

}
