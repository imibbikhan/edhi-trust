//
//  BloodRequestModel.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
struct BloodRequestModel: Codable {
    let requestKey, referCity, gender, bloodGroup: String
    let fullAddress, phoneNumber, age, requestType: String
    let bloodFor, userKey: String
    
    enum CodingKeys: String, CodingKey {
        case requestKey = "request_key"
        case referCity = "refer_city"
        case gender
        case bloodGroup = "blood_group"
        case fullAddress = "full_address"
        case phoneNumber = "phone_number"
        case age
        case requestType = "request_type"
        case bloodFor = "blood_for"
        case userKey = "user_key"
    }
}
