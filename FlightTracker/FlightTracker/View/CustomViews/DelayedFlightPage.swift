//
//  DelayedFlightPage.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 3.12.2023.
//

import UIKit

class DelayedFlightPage: UIView,  UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    let filterButton = UIButton()
    let selectionStack = UIStackView()
    lazy var typePicker = UIPickerView()
    lazy var delayTimePicker = UIPickerView()
    lazy var typeTextField = UITextField()
    lazy var timeTextField = UITextField()
    let searchBar = UISearchBar()
    let delayedTableView = UITableView()
    
    let type: [String] = ["arrivals", "departures"]
    let duration: [Int] = Array(30...180)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        setGradientBackground()
        backgroundColor = .dynamicBG
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        let selectionStack = UIStackView()
        selectionStack.axis = .horizontal
        selectionStack.spacing = 100
        addSubview(selectionStack)
        selectionStack.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
        }
        
        
        let typeStack = UIStackView()
        typeStack.axis = .vertical
        selectionStack.addArrangedSubview(typeStack)

        let typeLabel = UILabel()
        typeLabel.text = "Flight Type"
        typeLabel.textColor = .dynamicText
        typeLabel.textAlignment = .center
        typeLabel.numberOfLines = 0
        typeLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        typeStack.addArrangedSubview(typeLabel)
        
        typeTextField.inputView = typePicker
        typeTextField.textColor = .dynamicText
        typeTextField.placeholder = "Flight Type"
        typeTextField.textAlignment = .center
        typeStack.addArrangedSubview(typeTextField)

        let timeStack = UIStackView()
        timeStack.axis = .vertical
        selectionStack.addArrangedSubview(timeStack)

        let delayTimeLabel = UILabel()
        delayTimeLabel.text = "Delay Time"
        delayTimeLabel.textColor = .dynamicText
        delayTimeLabel.textAlignment = .center
        delayTimeLabel.numberOfLines = 0
        delayTimeLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        timeStack.addArrangedSubview(delayTimeLabel)
        
        timeTextField.inputView = delayTimePicker
        timeTextField.textColor = .dynamicText
        timeTextField.placeholder = "Select a time"
        timeTextField.textAlignment = .center
        timeStack.addArrangedSubview(timeTextField)
        
        searchBar.placeholder = "Search Flight"
        searchBar.barTintColor = .clear
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = .systemGray5
        searchBar.searchTextField.borderStyle = .roundedRect
        searchBar.searchTextField.layer.borderWidth = 0.5
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.backgroundColor = .clear
        addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(selectionStack.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(10)
        }
                
        delayedTableView.backgroundColor = .clear
        delayedTableView.register(DelayedFlightsTableViewCell.self, forCellReuseIdentifier: DelayedFlightsTableViewCell.identifier)
        delayedTableView.dataSource = self
        delayedTableView.delegate = self
        addSubview(delayedTableView)
        delayedTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DelayedFlightsTableViewCell.identifier, for: indexPath) as! DelayedFlightsTableViewCell
        
        return cell
    }
    
}
