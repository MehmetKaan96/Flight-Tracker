//
//  DelayedFlightPage.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 3.12.2023.
//

import UIKit

class DelayedFlightPage: UIView, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    let selectionStack = UIStackView()
    lazy var typePicker = UIPickerView()
    lazy var delayTimePicker = UIPickerView()
    lazy var typeTextField = UITextField()
    lazy var timeTextField = UITextField()
    
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
        
        typePicker.delegate = self
        typePicker.dataSource = self
        
        delayTimePicker.delegate = self
        delayTimePicker.dataSource = self
        
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
        typeTextField.delegate = self
        typeTextField.textColor = .black
        typeTextField.placeholder = "Flight Type"
        typeTextField.textAlignment = .center
        selectionStack.addArrangedSubview(typeTextField)
        
        timeTextField.delegate = self
        timeTextField.inputView = delayTimePicker
        timeTextField.textColor = .black
        timeTextField.placeholder = "Select a time"
        timeTextField.textAlignment = .center
        selectionStack.addArrangedSubview(timeTextField)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == typePicker {
            return type.count
        } else if pickerView == delayTimePicker {
            return duration.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == typePicker {
                return type[row]
            } else if pickerView == delayTimePicker {
                return "\(duration[row]) min"
            }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == typePicker {
            let selectedRow = typePicker.selectedRow(inComponent: 0)
            typeTextField.text = type[selectedRow]
            typeTextField.resignFirstResponder()
        } else if pickerView == delayTimePicker {
            let selectedRow = delayTimePicker.selectedRow(inComponent: 0)
            timeTextField.text = "\(duration[selectedRow]) min"
            timeTextField.resignFirstResponder()
        }
    }
}
