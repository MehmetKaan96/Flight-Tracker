//
//  DelayedFlightsViewController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 3.12.2023.
//

import UIKit

final class DelayedFlightsViewController: UIViewController {
    
    let viewModel: DelayedFlightViewModel
    let page = DelayedFlightPage()
    private let animatedView = UIView()
    
    init(viewModel: DelayedFlightViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
    }
        
    private func createUI() {
        navigationItem.title = "Delayed Flights".localized()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isNavigationBarHidden = true
        view.addSubview(page)
        page.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        page.typeTextField.delegate = self
        page.timeTextField.delegate = self
        
        page.typePicker.delegate = self
        page.typePicker.dataSource = self
        
        page.delayTimePicker.delegate = self
        page.delayTimePicker.dataSource = self
        
        page.searchBar.delegate = self
        
        page.delayedTableView.delegate = self
        page.delayedTableView.dataSource = self
        
        animatedView.frame = CGRect(x: 0, y: view.frame.size.height, width: 200, height: 200)
        animatedView.backgroundColor = .red
        view.addSubview(animatedView)
    }
}
