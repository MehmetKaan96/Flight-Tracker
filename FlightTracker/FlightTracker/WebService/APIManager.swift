//
//  APIManager.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 17.11.2023.
//

import Foundation

class APIManager: FlightDataService {
    func fetchFlights(completion: @escaping (Result<[Flights], NetworkError>) -> Void) {
        guard let url = URL(string: Constants.baseURL + Constants.API_KEY) else { completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed))
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(FlightsResponse.self, from: data)
                completion(.success(decodedData.response))
            } catch {
                completion(.failure(.decodeError))
            }
        }).resume()
        
    }
}
