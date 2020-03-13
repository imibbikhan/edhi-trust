//
//  User.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 13/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
import Firebase

class User {
    static func getUid()->String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    static func getPhoneNumber()->String {
        return Auth.auth().currentUser?.phoneNumber ?? ""
    }
    static func setDisplayName(name: String) {
        let request = Auth.auth().currentUser?.createProfileChangeRequest()
        request?.displayName = name
        request?.commitChanges()
    }
    static func setPhotoURL(url: String) {
        guard let url = URL(string: url) else { return }
        let request = Auth.auth().currentUser?.createProfileChangeRequest()
        request?.photoURL = url
        request?.commitChanges()
    }
}
