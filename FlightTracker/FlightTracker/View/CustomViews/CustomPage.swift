//
//  CustomPage.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 19.11.2023.
//

import UIKit

class CustomPage: UIView, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    var tableViewController: UITableViewController?
    let searchBar = UISearchBar()
    
    init(tableViewController: UITableViewController?) {
        super.init(frame: .zero)
        guard let tableViewController = tableViewController else { return }
        self.tableViewController = tableViewController
        createUI()
        setGradientBackground()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradientBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.85)
        }
        
        // Add Search Bar
        searchBar.delegate = self
        contentView.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.left.right.equalTo(contentView).inset(8)
        }
        
        // Add Table View
        if let tableView = tableViewController?.tableView {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            contentView.addSubview(tableView)
            tableView.snp.makeConstraints { make in
                make.top.equalTo(searchBar.snp.bottom).offset(8)
                make.left.right.bottom.equalToSuperview()
            }
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private func setGradientBackground() {
        let colorTop = UIColor.gradientTop.cgColor
        let colorBottom = UIColor.theme.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.4]
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flightsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = flightsArray[indexPath.row].aircraft_icao
        return cell
    }
    
    
}
