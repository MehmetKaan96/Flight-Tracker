//
//  MainListViewController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 19.11.2023.
//

import UIKit

class MainListViewController: UIViewController  {
    
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.setGradientBackground()
    }
    
    private func createUI() {
        let service: FlightDataService = APIManager()
        let viewModel = RealtimeFlightsViewModel(flightsService: service)
        viewModel.delegate = self
        viewModel.fetchFlights()
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Flight"
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.delegate = self
        searchBar.backgroundColor = .clear
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(150)
            make.left.right.equalToSuperview().inset(10)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 15
        tableView.backgroundColor = .clear
        tableView.register(FlightsTableViewCell.self, forCellReuseIdentifier: FlightsTableViewCell.identifier)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
        
    }
    
}
