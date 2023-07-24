//
//  FlightsCollectionViewCell.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 21.07.2023.
//

import UIKit
import RxCocoa
import RxSwift
import RealmSwift

class FlightsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var flightIATALabel: UILabel!
    @IBOutlet weak var arrIATALabel: UILabel!
    @IBOutlet weak var depIATALabel: UILabel!
    @IBOutlet weak var aircraftICAOLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var flightPathView: UIView!
    @IBOutlet weak var regNumber: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    var flight: FavouriteFlights! {
        didSet {
            configureCell(with: flight)
        }
    }
    
    var disposeBag = DisposeBag()
    
    var isFavourite = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favouriteButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                if self.isFavourite {
                    self.deleteFlightFromRealm(self.flight)
                    self.favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                    self.favouriteButton.tintColor = .systemBlue
                    self.isFavourite = false
                }
                else {
                    self.saveFlightToRealm(self.flight)
                    self.favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    self.favouriteButton.tintColor = .systemPink
                    self.isFavourite = true
                }
            })
            .disposed(by: disposeBag)
        self.setupGradientBackground(isVertical: false, alpha: 0.4)
        flightPathView.drawFlightPath()
        self.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func configureCell(with flight: FavouriteFlights) {
        if flight.isFavourite {
            self.favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.favouriteButton.tintColor = .systemPink
            self.isFavourite = true
        } else {
            self.favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            self.favouriteButton.tintColor = .systemBlue
            self.isFavourite = false
        }
    }
    
    private func saveFlightToRealm(_ flight: FavouriteFlights) {
        do {
            let realm = try Realm()
            
            try realm.write {
                flight.isFavourite = true
                realm.add(flight)
            }
        } catch {
            print("Error saving flight to Realm: \(error)")
        }
    }
    
    func deleteFlightFromRealm(_ flight: FavouriteFlights) {
        do {
            let realm = try Realm()
            try realm.write {
                flight.isFavourite = false
                realm.delete(flight)
            }
        } catch {
            print("Error deleting flight from Realm: \(error)")
        }
    }
}
