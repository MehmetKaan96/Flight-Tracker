//
//  NetworkError.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 17.11.2023.
//

import Foundation

enum NetworkError: Error {
    case requestFailed
    case invalidData
    case decodeError
    var localizedDescription: String {
        switch self {
        case .requestFailed:
            return "Request Failed"
        case .invalidData:
            return "Invalid Data"
        case .decodeError:
            return "Decoding Error"
        }
    }
}
