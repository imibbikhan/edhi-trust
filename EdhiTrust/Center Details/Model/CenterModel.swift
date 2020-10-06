//
//  CenterModel.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/10/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
struct CenterModel: Codable {
    let aPositive, aNegative, abPositive, bNegative, bPositive, oNegative, oPositive, totalChildren, centerName, totalOrphans, totalWidows: String
    
    enum CodingKeys: String, CodingKey {
        case aPositive = "a_positive_group"
        case aNegative = "a_negative_group"
        case abPositive = "ab_group"
        case bPositive = "b_positive_group"
        case bNegative = "b_negative_group"
        case oNegative = "o_negative_group"
        case oPositive = "o_positive_group"
        case centerName = "center_name"
        case totalChildren = "total_children"
        case totalOrphans = "total_orphans"
        case totalWidows = "total_widows"
    }
}

struct CenterDetail {
    let keyTitle, valueTitle: String
}
