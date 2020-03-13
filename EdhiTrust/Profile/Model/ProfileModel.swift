//
//  ProfileModel.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 13/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//
import Foundation
import UIKit
struct ProfileModel {
    struct Profile: Codable {
        let photoURL, email, displayName: String
        
        enum CodingKeys: String, CodingKey {
            case photoURL = "photo_url"
            case email
            case displayName = "display_name"
        }
    }
    struct EditProfile {
        let photo: UIImage
        let email, displayName: String
    }
}
