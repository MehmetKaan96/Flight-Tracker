//
//  FlightTrackerTests.swift
//  FlightTrackerTests
//
//  Created by Mehmet Kaan on 17.11.2023.
//

import XCTest
@testable import FlightTracker

final class FlightTrackerTests: XCTestCase {
    
    private var realtimeFlightsViewModel: RealtimeFlightsViewModel!
    private var flightDetailViewModel: FlightDetailsViewModel!
    private var delayedFlightsViewModel: DelayedFlightViewModel!
    
    private var apiService: MockAPIService!
    
    private var realTimeFlightsViewModelDelegate: MockRealtimeFlightsViewModelDelegate!
    private var flightDetailViewModelDelegate: MockFlightDetailsViewModelDelegate!
    private var delayedFlightsViewModelDelegate: MockDelayedFlightsViewModelDelegate!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apiService = MockAPIService()
        realtimeFlightsViewModel = RealtimeFlightsViewModel(flightsService: apiService)
        realTimeFlightsViewModelDelegate = MockRealtimeFlightsViewModelDelegate()
        realtimeFlightsViewModel.delegate = realTimeFlightsViewModelDelegate
        
        flightDetailViewModel = FlightDetailsViewModel(service: apiService)
        flightDetailViewModelDelegate = MockFlightDetailsViewModelDelegate()
        flightDetailViewModel.delegate = flightDetailViewModelDelegate
        
        delayedFlightsViewModel = DelayedFlightViewModel(flightService: apiService)
        delayedFlightsViewModelDelegate = MockDelayedFlightsViewModelDelegate()
        delayedFlightsViewModel.delegate = delayedFlightsViewModelDelegate
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetFlights_WhenAPISuccess_ShowResult() throws {
        let realTimeFlightsResult = Flights(reg_number: "B-5545", flag: "CN", lat: 28.397377, lng: 115.1008, alt: 7078, dir: 269, speed: 775, v_speed: -7.8, flight_number: "9429", flight_icao: "CSH9429", flight_iata: "FM9429", dep_icao: "ZSPD", dep_iata: "PVG", arr_icao: "ZGHY", arr_iata: "HNY", airline_icao: "CSH", airline_iata: "FM", aircraft_icao: "B738", status: "en-route")
        
        let mockFlights = [realTimeFlightsResult]
        apiService.RealTimeFlightMockResult = .success(mockFlights)
        realtimeFlightsViewModel.fetchFlights()
        
        XCTAssertEqual(realTimeFlightsViewModelDelegate.Flights.last?.status, "en-route")
        XCTAssertEqual(realTimeFlightsViewModelDelegate.Flights.last?.reg_number, "B-5545")
        XCTAssertNotNil(realTimeFlightsViewModelDelegate.Flights.last)
        XCTAssertEqual(realTimeFlightsViewModelDelegate.Flights.count, 1)
        
    }
    
    func testGetFlightInfo_WhenAPISuccess_ShowResult() throws {
        let depAirportResult = Airport(response: [Response(name: "Paris Charles de Gaulle Airport", iataCode: "CDG", icaoCode: "LFPG", lat: 49.009592, lng: 2.555675, countryCode: "FR")])
        
        let arrAirportResult = Airport(response: [Response(name: "Istanbul Airport", iataCode: "IST", icaoCode: "LTFM", lat: 41.2629, lng: 28.74242, countryCode: "TR")])
        
        let flightInfoResult = FlightInfo(aircraftIcao: "B772", age: 6, built: 2015, engine: "jet", engineCount: "2", model: "Airbus A321-100/200 Ceo", manufacturer: "AIRBUS", msn: "5938", type: "landplane", regNumber: "N790AN", airlineIata: "AA", airlineIcao: "AAL", flightIata: "AA6", flightIcao: "AAL6", flightNumber: "6", depIata: "OGG", depIcao: "PHOG", depTerminal: "M5", depGate: "29", depTime: "18:50", depEstimated: "18:50", depActual: "18:50", depTimeUTC: "18:50", depEstimatedUTC: "18:50", depActualUTC: "18:50", depTimeTs: 123, depEstimatedTs: 123, depActualTs: 123, arrIata: "DFW", arrIcao: "KDFW", arrTerminal: "A", arrGate: "A24", arrBaggage: "A28", arrTime: "07:04", arrEstimated: "07:04", arrTimeUTC: "07:04", arrEstimatedUTC: "07:04", arrTimeTs: 123, arrEstimatedTs: 123, status: "en-route", duration: 434, lat: 33.455017, lng: -118.738312, dir: 80, depName: depAirportResult.response.last?.name, depCity: "Paris", depCountry: depAirportResult.response.last?.countryCode, arrName: arrAirportResult.response.last?.name, arrCity: "Istanbul", arrCountry: arrAirportResult.response.last?.countryCode, airlineName: "Turkish Airlines")
        
        let mockDepAirport = depAirportResult
        let mockArrAirport = arrAirportResult
        let mockFlightInfo = FlightInfoResponse(response: flightInfoResult)
        
        apiService.FlightDetailMockResult = .success(mockFlightInfo)
        flightDetailViewModel.fetchFlightInfo(with: "AA6")
        flightDetailViewModel.fetchArrivalAirport(with: "IST")
        flightDetailViewModel.fetchDepartureAirport(with: "CDG")
        
        XCTAssertEqual(flightDetailViewModelDelegate.flightInfoResponse.flightIata, "AA6")
        XCTAssertNotNil(flightDetailViewModelDelegate.flightInfoResponse)
        XCTAssertEqual(flightDetailViewModelDelegate.flightInfoResponse.status, "en-route")
    }
    
    func testGetDelayedFlights_WhenAPISuccess_ShowResult() {
        let delayedFlights = DelayResponse(airlineIata: "BA", flightIata: "BA6984", depIata: "MIA", arrIata: "SFO", status: "scheduled", duration: 359, delayed: 137, depDelayed: 150, arrDelayed: 140, aircraftIcao: "B738")
        
        let mockDelayedFlights = DelayInfo(response: [delayedFlights])
        
        apiService.DelayedFlightsMockResult = .success(mockDelayedFlights)
        delayedFlightsViewModel.getDelayedFlights(with: "BA6984", and: "137")
        
        XCTAssertNotNil(delayedFlightsViewModelDelegate.delayInfo)
        XCTAssertEqual(delayedFlightsViewModelDelegate.delayInfo.count, 1)
        XCTAssertEqual(delayedFlightsViewModelDelegate.delayInfo.last?.flightIata, "BA6984")
        XCTAssertEqual(delayedFlightsViewModelDelegate.delayInfo.last?.status, "scheduled")
    }

}

class MockAPIService: FlightDataService {
    var RealTimeFlightMockResult: Result<[FlightTracker.Flights], FlightTracker.NetworkError>?
    var FlightDetailMockResult: Result<FlightTracker.FlightInfoResponse, FlightTracker.NetworkError>?
    var DelayedFlightsMockResult: Result<FlightTracker.DelayInfo, FlightTracker.NetworkError>?
    var GetAirportsMockResult: Result<FlightTracker.Airport, FlightTracker.NetworkError>?
    
    func fetchFlights(completion: @escaping (Result<[FlightTracker.Flights], FlightTracker.NetworkError>) -> Void) {
        if let result = RealTimeFlightMockResult {
            completion(result)
        }
    }
    
    func fetchFlightInfo(with flightCode: String, completion: @escaping (Result<FlightTracker.FlightInfoResponse, FlightTracker.NetworkError>) -> Void) {
        if let result = FlightDetailMockResult {
            completion(result)
        }
    }
    
    func getAirport(with code: String, completion: @escaping (Result<FlightTracker.Airport, FlightTracker.NetworkError>) -> Void) {
        if let result = GetAirportsMockResult {
            completion(result)
        }
    }
    
    func fetchDelayedFlights(with type: String, and minutes: String, completion: @escaping (Result<FlightTracker.DelayInfo, FlightTracker.NetworkError>) -> Void) {
        if let result = DelayedFlightsMockResult {
            completion(result)
        }
    }
}

class MockRealtimeFlightsViewModelDelegate: RealtimeFlightsViewModelDelegate {
    var Flights: [(reg_number: String?, flag: String?, lat: Double?, lng: Double?, alt: Int?, dir: Double?, speed: Int?,
                   v_speed: Double?, flight_number: String?, flight_icao: String?, flight_iata: String?, dep_icao: String?, dep_iata: String?, arr_icao: String?, arr_iata: String?, airline_icao: String?, airline_iata: String?, aircraft_icao: String?, status: String?)] = []
    func fetchFlights(_ flights: [FlightTracker.Flights]) {
        guard let regNumber = flights.last?.reg_number, let flag = flights.last?.flag, let lat = flights.last?.lat, let lng = flights.last?.lng, let alt = flights.last?.alt, let dir = flights.last?.dir, let speed = flights.last?.speed, let v_speed = flights.last?.v_speed, let flight_number = flights.last?.flight_number, let flight_icao = flights.last?.flight_icao, let flight_iata = flights.last?.flight_iata, let dep_icao = flights.last?.dep_icao, let dep_iata = flights.last?.dep_iata, let arr_icao = flights.last?.arr_icao, let arr_iata = flights.last?.arr_iata, let airline_icao = flights.last?.airline_icao, let airline_iata = flights.last?.airline_iata ,let aircraft_icao = flights.last?.aircraft_icao, let status = flights.last?.status else { return }
        
        Flights.append((regNumber, flag, lat, lng, alt, dir, speed, v_speed, flight_number, flight_icao, flight_iata, dep_icao, dep_iata, arr_icao, arr_iata, airline_icao, airline_iata, aircraft_icao, status))
    }
}

class MockFlightDetailsViewModelDelegate: FlightDetailsViewModelDelegate {
    var flightInfoResponse: FlightInfo!
    var arrAirportResponse: Airport!
    var depAirportResponse: Airport!
    
    func fetchFlightData(_ flight: FlightTracker.FlightInfoResponse) {
        flightInfoResponse = flight.response
        
    }
    
    func fetchDepartureAirport(_ airport: FlightTracker.Airport) {
        depAirportResponse = airport
    }
    
    func fetchArrivalAirport(_ airport: FlightTracker.Airport) {
        arrAirportResponse = airport
    }
}

class MockDelayedFlightsViewModelDelegate: DelayedFlightViewModelDelegate {
    var delayInfo: [(airlineIata: String?, flightIata: String?, depIata: String?, arrIata: String?, status: String?, duration: Int?, delayed: Int?, depDelayed: Int?, arrDelayed: Int?, aircraftIcao: String?)] = []
    
    func getDelayedFlights(_ flights: [FlightTracker.DelayResponse]) {
        guard let airlineIata = flights.last?.airlineIata, let flightIata = flights.last?.flightIata, let depIata = flights.last?.depIata, let arrIata = flights.last?.arrIata, let status = flights.last?.status, let duration = flights.last?.duration, let delayed = flights.last?.delayed, let depDelayed = flights.last?.depDelayed, let arrDelayed = flights.last?.arrDelayed, let aircraftIcao = flights.last?.aircraftIcao else { return }
        
        delayInfo.append((airlineIata, flightIata, depIata, arrIata, status, duration, delayed, depDelayed, arrDelayed, aircraftIcao))
    }
}
