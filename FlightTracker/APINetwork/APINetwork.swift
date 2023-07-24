import Foundation
import RxSwift
import RxCocoa

enum NetworkError: Error {
    case invalidURL
    case invalidData
}

class APINetwork {
    static let shared = APINetwork()
    private let disposeBag = DisposeBag()
    private let decoder = JSONDecoder()

    private func makeRequest<T: Decodable>(url: URL) -> Observable<T> {
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    observer.onError(error)
                    return
                }

                guard let data = data else {
                    observer.onError(NetworkError.invalidData)
                    return
                }

                do {
                    let decodedData = try self.decoder.decode(T.self, from: data)
                    observer.onNext(decodedData)
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }

            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }

    func fetchFlights() -> Observable<[Flights]> {
        guard let url = URL(string: "\(Constants.apiURL)flights?api_key=\(Constants.API_KEY)") else {
            return Observable.error(NetworkError.invalidURL)
        }

        return makeRequest(url: url)
            .map { ($0 as FlightsResponse).response }
            .catchError { error in
                if let networkError = error as? NetworkError {
                    return Observable.error(networkError)
                } else {
                    return Observable.error(NetworkError.invalidData)
                }
            }
    }

    func startFetchingFlights(every interval: TimeInterval) -> Observable<[Flights]> {
        return Observable<Int>.interval(.seconds(Int(interval)), scheduler: MainScheduler.instance)
            .flatMap { _ in self.fetchFlights() }
    }

    func fetchFlightInfo(flightIata: String) -> Observable<FlightInfo> {
        guard let url = URL(string: "\(Constants.apiURL)flight?flight_iata=\(flightIata)&api_key=\(Constants.API_KEY)") else {
            return Observable.error(NetworkError.invalidURL)
        }

        return makeRequest(url: url)
            .map { ($0 as FlightInfoResponse).response }
            .catchError { error in
                if let networkError = error as? NetworkError {
                    return Observable.error(networkError)
                } else {
                    return Observable.error(NetworkError.invalidData)
                }
            }
    }

    func fetchDelayedFlights(with duration: String, flightType type: String) -> Observable<InfoResponse> {
        guard let url = URL(string: "\(Constants.apiURL)delays?delay=\(duration)&type=\(type)&api_key=\(Constants.API_KEY)") else {
            return Observable.error(NetworkError.invalidURL)
        }

        return makeRequest(url: url)
            .catchError { error in
                if let networkError = error as? NetworkError {
                    return Observable.error(networkError)
                } else {
                    return Observable.error(NetworkError.invalidData)
                }
            }
    }
}
