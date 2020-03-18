//
//  AmbulanceDelegate.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 18/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
protocol AmbulancesDelegate {
    func ambulancesFetched(ambulances: [AmbulanceModel])
    func error(message: String)
}
