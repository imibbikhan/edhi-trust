//
//  BloodRequestDelegate.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
protocol PostBloodRequestDelegate {
    func postSuccess()
    func error(message: String)
}
protocol BloodRequestsDelegate {
    func requestsFetched(requests: [BloodRequestModel])
    func error(message: String)
}
