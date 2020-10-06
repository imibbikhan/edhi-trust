//
//  CallCenterModel.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/10/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
struct CallCenterModel: Codable {
    let name, number, address: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name_center"
        case number = "center_number"
        case address = "center_address"
    }
}
