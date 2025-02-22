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
let BLOOD_COLOR_CODE = "ED9393"

// MARK: - COLORS
let EDHI_PRIMARY = UIColor.black
let BLOOD_COLOR = UIColor(hexString: BLOOD_COLOR_CODE)

// MARK: - Repeated
let STORYBOARD = UIStoryboard(name: "Main", bundle: nil)
let DEFAULTS = UserDefaults.standard
let GOOGLE_MAP_KEY = "AIzaSyC7aO2ri5wsZEBhI3iqm70A1-m7vTYmehg"
let FB_DB_REF = Database.database().reference()
let FB_ST_REF = Storage.storage().reference()
