//
//  AmbulanceModel.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 18/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation

struct AmbulanceModel: Codable {
    let ambulanceKey, city, driverName: String
    let location: Location
    let phoneNumber: String
    var onDistance: Double?
    let isAvailable: String
    
    
    enum CodingKeys: String, CodingKey {
        case ambulanceKey = "ambulance_key"
        case city
        case driverName = "driver_name"
        case location
        case phoneNumber = "phone_number"
        case isAvailable = "is_available"
        case onDistance
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        onDistance = try values.decodeIfPresent(Double.self, forKey: .onDistance) ?? 0.0
        ambulanceKey = try values.decodeIfPresent(String.self, forKey: .ambulanceKey) ?? ""
        city = try values.decodeIfPresent(String.self, forKey: .city) ?? ""
        driverName = try values.decodeIfPresent(String.self, forKey: .driverName) ?? ""
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber) ?? ""
        isAvailable = try values.decodeIfPresent(String.self, forKey: .isAvailable) ?? ""
        location = try values.decodeIfPresent(Location.self, forKey: .location) ?? Location(lati: 0, longi: 0)
    }
}

struct Location: Codable {
    let lati, longi: Double
}
