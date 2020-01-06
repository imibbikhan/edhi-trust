//
//  Constants.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
import UIKit
import Firebase

// MARK: - Color codes
let PRIMARY_COLOR = "5ABA4A"
let LIGHT_GREY_COLOR = "AAAAAA"
let BACKGROUND_GREY_COLOR = "FAFAFA"

// MARK: - COLORS
let EDHI_PRIMARY = UIColor(hexString: PRIMARY_COLOR)

// MARK: - Repeated
let STORYBOARD = UIStoryboard(name: "Main", bundle: nil)
let DEFAULTS = UserDefaults.standard
let GOOGLE_MAP_KEY = "AIzaSyBzMuHUjLd1vJdtwbVO5-1ePPAO_ggsHfU"
let FB_DB_REF = Database.database().reference()
let FB_ST_REF = Storage.storage().reference()
