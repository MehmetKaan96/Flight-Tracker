//
//  IntExtension.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 3.12.2023.
//

import Foundation

extension Int {
    func convertDuration() -> String {
        let hour = self / 60
        let minute = self % 60
        
        return "\(hour)H:\(minute)M"
    }
}
