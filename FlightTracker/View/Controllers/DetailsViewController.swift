//
//  DetailsViewController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 11.07.2023.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var airplaneImage: UIImageView!
    @IBOutlet weak var flightPathView: UIView!
    @IBOutlet weak var flightPlaceMap: MKMapView!
    @IBOutlet weak var flightStatusLabel: UILabel!
    @IBOutlet weak var flightDurationLabel: UILabel!
    @IBOutlet weak var aircraftICAOLabel: UILabel!
    @IBOutlet weak var departureCityLabel: UILabel!
    @IBOutlet weak var departureIATALabel: UILabel!
    @IBOutlet weak var arrivalIATALabel: UILabel!
    @IBOutlet weak var arrivalCityLabel: UILabel!
    @IBOutlet weak var arrTerminalGateLabel: UILabel!
    @IBOutlet weak var depTerminalGateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    lazy var viewModel: FlightInfoViewModel = {
        return FlightInfoViewModel()
    }()
    let disposeBag = DisposeBag()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flightPlaceMap.delegate = self
        setupBindings()
        outerView.layer.borderWidth = 1
        flightPathView.drawFlightPath()
        innerView.setupGradientBackground()
        innerView.layer.cornerRadius = 10
        view.setupGradientBackground()
    }
    
}
