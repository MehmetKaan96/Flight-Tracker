//
//  NetworkError.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 17.11.2023.
//

import Foundation

enum NetworkError: Error {
    case requestFailed(String)
    case invalidData
    case decodeError
    case invalidURL
    
    var localizedDescription: String {
        switch self {
        case .requestFailed(let message):
            return "Request Failed: \(message)"
        case .invalidData:
            return "Invalid Data"
        case .decodeError:
            return "Decoding Error"
        case .invalidURL:
            return "Invalid URL"
        }
    }
}
