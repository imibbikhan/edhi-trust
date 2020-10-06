//
//  DonationModel.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 04/10/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
struct DonationModel: Codable {
    let contactNumber, estimatedCost, city, address: String
    
    enum CodingKeys: String, CodingKey {
        case contactNumber = "donor_number"
        case estimatedCost = "item_price"
        case city = "donor_city"
        case address = "donor_address"
    }
}
