//
//  StringExtension.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 3.12.2023.
//

import Foundation

extension String {
    func formatDateTimeToTime() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        if let date = dateFormatter.date(from: self) {
            let userCalendar = Calendar.current
            dateFormatter.dateFormat = "h:mm a"
            dateFormatter.timeZone = TimeZone.current

            let formattedTime = dateFormatter.string(from: date)
            return formattedTime
        }

        return nil
    }
}
