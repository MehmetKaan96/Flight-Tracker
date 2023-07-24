//
//  ViewController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 18.06.2023.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let viewModel = FlightsListViewModel()
    let infoViewModel = FlightInfoViewModel()
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var mapViewController: MapViewController = MapViewController()
    let disposeBag = DisposeBag()
    var flightDurationsCache: [String: Int] = [:]
    
    @IBOutlet weak var flightsListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.selectedSegmentIndex = 0
        segmentControlObservable()
        
        setupTableView()
        bindViewModelToCollectionView()
        viewModel.fetchFlights()
        view.setupGradientBackground()
    }
    
}

