//
//  DelayedFlightPage.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 3.12.2023.
//

import UIKit

class DelayedFlightPage: UIView,  UITextFieldDelegate {
    
    let selectionStack = UIStackView()
    lazy var typePicker = UIPickerView()
    lazy var delayTimePicker = UIPickerView()
    lazy var typeTextField = UITextField()
    lazy var timeTextField = UITextField()
    let searchBar = UISearchBar()
    
    let type: [String] = ["arrival", "departure"]
    let duration: [Int] = Array(30...180)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradientBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        
        let typeLabel = UILabel()
        typeLabel.text = "Flight Type"
        typeLabel.textColor = .black
        typeLabel.textAlignment = .center
        typeLabel.numberOfLines = 0
        typeLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        addSubview(typeLabel)
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(50)
        }
        
        let delayTimeLabel = UILabel()
        delayTimeLabel.text = "Delay Time"
        delayTimeLabel.textColor = .black
        delayTimeLabel.textAlignment = .center
        delayTimeLabel.numberOfLines = 0
        delayTimeLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        addSubview(delayTimeLabel)
        delayTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.right.equalToSuperview().inset(50)
        }
        
        selectionStack.axis = .horizontal
        selectionStack.distribution = .fillEqually
        selectionStack.alignment = .fill
        addSubview(selectionStack)
        selectionStack.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(5)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
        }
        
        typeTextField.inputView = typePicker
        typeTextField.textColor = .black
        typeTextField.placeholder = "Flight Type"
        typeTextField.textAlignment = .center
        selectionStack.addArrangedSubview(typeTextField)
        
        timeTextField.inputView = delayTimePicker
        timeTextField.textColor = .black
        timeTextField.placeholder = "Select a time"
        timeTextField.textAlignment = .center
        selectionStack.addArrangedSubview(timeTextField)
        
        searchBar.placeholder = "Search Flight"
        searchBar.barTintColor = .clear
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.searchTextField.borderStyle = .roundedRect
        searchBar.searchTextField.layer.borderWidth = 0.5
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.backgroundColor = .clear
        addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(timeTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(10)
        }
    }
    
}

#Preview() {
    DelayedFlightPage()
}
