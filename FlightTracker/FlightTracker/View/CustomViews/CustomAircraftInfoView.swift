//
//  CustomAircraftInfoView.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 21.11.2023.
//

import Foundation
import UIKit
import SnapKit

class CustomAircraftInfoView: UIView {
    let infoText1 = UILabel()
    let infoText2 = UILabel()
    let infoText3 = UILabel()
    
    let info1Detail = UILabel()
    let info2Detail = UILabel()
    let info3Detail = UILabel()
    
    init(info1: String, info2: String, info3: String) {
        self.infoText1.text = info1
        self.infoText2.text = info2
        self.infoText3.text = info3
        super.init()
        self.setupLabels(text1: info1, text2: info2, text3: info3)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        
        let labelStack = UIStackView()
        labelStack.alignment = .fill
        labelStack.distribution = .fillEqually
        labelStack.axis = .horizontal
        addSubview(labelStack)
        labelStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview()
        }
        
        
        infoText1.textAlignment = .left
        infoText1.numberOfLines = 0
        infoText1.textColor = .systemGray
        infoText1.font = .systemFont(ofSize: 17, weight: .medium)
        labelStack.addArrangedSubview(infoText1)
        
        infoText2.textAlignment = .center
        infoText2.numberOfLines = 0
        infoText2.textColor = .systemGray
        infoText2.font = .systemFont(ofSize: 17, weight: .medium)
        labelStack.addArrangedSubview(infoText2)
        
        infoText3.textAlignment = .right
        infoText3.numberOfLines = 0
        infoText3.textColor = .systemGray
        infoText3.font = .systemFont(ofSize: 17, weight: .medium)
        labelStack.addArrangedSubview(infoText3)

        
        
        let detailStack = UIStackView()
        detailStack.axis = .horizontal
        detailStack.distribution = .fillEqually
        detailStack.alignment = .fill
        addSubview(detailStack)
        detailStack.snp.makeConstraints { make in
            make.top.equalTo(labelStack.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
        }
        
        info1Detail.font = .systemFont(ofSize: 18, weight: .medium)
        info1Detail.textAlignment = .left
        info1Detail.numberOfLines = 0
        detailStack.addArrangedSubview(info1Detail)
        
        info2Detail.font = .systemFont(ofSize: 18, weight: .medium)
        info2Detail.textAlignment = .center
        info2Detail.numberOfLines = 0
        detailStack.addArrangedSubview(info2Detail)
        
        info3Detail.font = .systemFont(ofSize: 18, weight: .medium)
        info3Detail.textAlignment = .right
        info3Detail.numberOfLines = 0
        detailStack.addArrangedSubview(info3Detail)
    }
    
    private func setupLabels(text1: String, text2: String, text3: String) {
        self.infoText1.text = text1
        self.infoText2.text = text2
        self.infoText3.text = text3
    }
    
    func setInfoDetail1(with text: String) {
        self.info1Detail.text = text
    }
    
    func setInfoDetail2(with text: String) {
        self.info2Detail.text = text
    }
    
    func setInfoDetail3(with text: String) {
        self.info3Detail.text = text
    }
}
