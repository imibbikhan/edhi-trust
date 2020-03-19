//
//  StartHomeDelegate.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 19/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
protocol StartHomeDelegate {
    func bloodRequestsFetched(requests: [BloodRequestModel])
    func missingRequestsFetched(missings: [MissingModel])
    func error(message: String)
}
