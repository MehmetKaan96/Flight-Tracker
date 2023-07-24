import Foundation

struct FlightsResponse: Codable {
    let response: [Flights]
}

struct Flights: Codable {
    let lat: Double
    let lng: Double
    let alt: Int
    let dir: Int?
    let speed: Int
    let vSpeed: Double?
    let flightIata: String?
    let depIata: String?
    let arrIata: String?
    let airlineIata: String?
    let status: String?
    let aircraftIcao: String?
    let regNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lng
        case alt
        case dir
        case speed
        case vSpeed = "v_speed"
        case flightIata = "flight_iata"
        case depIata = "dep_iata"
        case arrIata = "arr_iata"
        case airlineIata = "airline_iata"
        case aircraftIcao = "aircraft_icao"
        case regNumber = "reg_number"
        case status
    }
}
