//
//  IntExtension.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 3.12.2023.
//

import Foundation

extension Int {
    func convertDuration() -> String {
        let hours = self / 60
        let minutes = self % 60
        
        let hourString = hours > 0 ? "\(hours)h" : ""
        let minuteString = minutes > 0 ? "\(minutes)m" : ""
        
        let timeString = [hourString, minuteString].joined(separator: " ")
        
        return timeString.isEmpty ? "No flight time" : "Total \(timeString) flight time".localized()
    }
}
