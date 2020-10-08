//
//  AmbulancesPresenter.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 18/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
import CoreLocation
import CodableFirebase
class AmbulancesPresenter {
    var delegate: AmbulancesDelegate?
    
    func getAmbulances(myLocation: CLLocation) {
        guard let delegate = self.delegate else { return }
        DBHandler.shared.getAmbulances(city: "kohat", myLocation: myLocation) { (ambulances, error) in
            if let err = error {
                delegate.error(message: err)
                return
            }
            delegate.ambulancesFetched(ambulances: ambulances)
        }
    }
    func encodeNow(ambulance: AmbulanceModel)->Any{
        do {
            let data = try FirebaseEncoder().encode(ambulance)
            return data
        }catch{
            print(error.localizedDescription)
        }
        return ""
    }
//    func sendNot
}
