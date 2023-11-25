//
//  APIManager.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 17.11.2023.
//

import Foundation

class APIManager: FlightDataService {
    func fetchFlights(completion: @escaping (Result<[Flights], NetworkError>) -> Void) {
        guard let url = URL(string: Constants.baseURL + Constants.allFlights + Constants.API_KEY) else { completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let _ = error {
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
    
    
    func fetchFlightInfo(with flightCode: String, completion: @escaping (Result<FlightInfo, NetworkError>) -> Void) {
        guard let url = URL(string: Constants.baseURL + Constants.flightInfo + "\(flightCode)&api_key=" + Constants.API_KEY ) else { completion(.failure(.invalidURL))
        return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let _ = error {
                completion(.failure(.requestFailed))
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(FlightInfo.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodeError))
            }
        }).resume()
    }
    
    func getAirport(with code: String, completion: @escaping (Result<Airport, NetworkError>) -> Void) {
        guard let url = URL(string: Constants.baseURL + Constants.airports + "\(code)&api_key=" + Constants.API_KEY) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let _ = error {
                completion(.failure(.requestFailed))
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(Airport.self, from: data)
                completion(.success(decodedData))
            } catch  {
                completion(.failure(.decodeError))
            }
            
        }).resume()
    }
    
}
