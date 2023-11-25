//
//  MainListViewController.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 19.11.2023.
//

import UIKit

class MainListViewController: UIViewController  {
    let searchBar = UISearchBar()
    let viewModel: RealtimeFlightsViewModel
    
    let tableView = UITableView()
    
    init(viewModel: RealtimeFlightsViewModel) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
        searchBar.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(150)
            make.left.right.equalToSuperview().inset(10)
        }
        
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.setGradientBackground()
    }
    
    private func createUI() {
        
        searchBar.placeholder = "Search Flight"
        searchBar.barTintColor = .clear
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.searchTextField.borderStyle = .roundedRect
        searchBar.searchTextField.layer.borderWidth = 0.5
        searchBar.searchTextField.layer.cornerRadius = 10
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
