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
        navigationItem.title = "Delayed Flights"
        navigationController?.navigationBar.prefersLargeTitles = true
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
        
//        page.filterButton.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        
        animatedView.frame = CGRect(x: 0, y: view.frame.size.height, width: 200, height: 200)
        animatedView.backgroundColor = .red
        view.addSubview(animatedView)
    }
    
    func fetchStatus(completion: @escaping () -> ()) {
        APIManager().fetchFlights { result in
            switch result {
            case .success(let flights):
                    completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func sayHello() {
        print("Hello")
    }
    
//    @objc func filterTapped() {
//        UIView.animate(withDuration: 0.5) {
//                self.animatedView.frame.origin = CGPoint(x: self.view.frame.size.width / 2 - self.animatedView.frame.size.width / 2,
//                                                         y: self.view.frame.size.height / 2 - self.animatedView.frame.size.height / 2)
//            }
//    }
}
