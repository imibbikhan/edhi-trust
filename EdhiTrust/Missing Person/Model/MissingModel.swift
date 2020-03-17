//
//  MissingModel.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 15/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
struct MissingModel: Codable {
    let missingKey, missingName, city, address: String
    let gender, phoneNumber, age: String
    let imageURL, missingStatus, userKey, disappearedDate: String
    let dissappearedCity: String
    
    enum CodingKeys: String, CodingKey {
        case missingKey = "missing_key"
        case missingName = "missing_name"
        case city, address, gender
        case phoneNumber = "phone_number"
        case age
        case imageURL = "image_url"
        case missingStatus = "missing_status"
        case userKey = "user_key"
        case disappearedDate = "disappeared_date"
        case dissappearedCity = "dissappeared_city"
    }
}
