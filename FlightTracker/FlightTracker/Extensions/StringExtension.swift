//
//  StringExtension.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 3.12.2023.
//

import Foundation

extension String {
    func formatDateTimeToTime() -> String? {
        let inputDateFormat = "yyyy-MM-dd HH:mm"
        let outputDateFormat = "h:mm a"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputDateFormat
        
        if let date = dateFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = outputDateFormat
            outputFormatter.timeZone = TimeZone.current
            
            let formattedTime = outputFormatter.string(from: date)
            return formattedTime
        }
        
        return nil
    }
}
