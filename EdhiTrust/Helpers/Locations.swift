//
//  Locations.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 18/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
import CoreLocation

class Locations {
    static func getDistance(destination: CLLocationCoordinate2D, myLocation: CLLocation)->Double{
        let coordinate1 = CLLocation(latitude: destination.latitude, longitude: destination.longitude)
        let distanceInMeters = myLocation.distance(from: coordinate1)
        return Double(distanceInMeters)
    }
    static func getGeoAddress(location: CLLocation, address: @escaping (String)->()) {
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) in
            var addressText = ""
            if error != nil {
                addressText = "Erro occure while getting address."
            }else if let name = placemarks?.first?.name {
                let addressInText = "\(name)" // , \(country) , \(city)
                addressText = addressInText
            }
            else {
                addressText = "No address found."
            }
            address(addressText)
        })
    }
}
