//
//  RealmFlightInfo.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 27.12.2023.
//

import Foundation
import RealmSwift

class RealmFlightInfo: Object, Codable {
    @Persisted var flightIata: String?
    @Persisted var depIata: String?
    @Persisted var depTime: String?
    @Persisted var depEstimated: String?
    @Persisted var arrIata: String?
    @Persisted var arrTime: String?
    @Persisted var arrEstimated: String?
    @Persisted var status: String?
    @Persisted var depCity: String?
    @Persisted var arrCity: String?
}

var favFlights: [RealmFlightInfo] = []
