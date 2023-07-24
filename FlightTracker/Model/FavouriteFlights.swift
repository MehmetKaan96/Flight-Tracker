//
//  FavouriteFlights.swift
//  FlightTracker
//
//  Created by Mehmet Kaan on 19.07.2023.
//

import RealmSwift

class FavouriteFlights: Object {
    @objc dynamic var isFavourite: Bool = false
    @objc dynamic var lat: Double = 0.0
    @objc dynamic var lng: Double = 0.0
    @objc dynamic var alt: Int = 0
    @objc dynamic var dir: Int = 0
    @objc dynamic var speed: Int = 0
    @objc dynamic var vSpeed: Double = 0.0
    @objc dynamic var flightIata: String? = nil
    @objc dynamic var depIata: String? = nil
    @objc dynamic var arrIata: String? = nil
    @objc dynamic var airlineIata: String? = nil
    @objc dynamic var status: String? = nil
    @objc dynamic var aircraftIcao: String? = nil
}
