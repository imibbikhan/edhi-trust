//
//  AppDelegate.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/01/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GMSServices.provideAPIKey(GOOGLE_MAP_KEY)
        GMSPlacesClient.provideAPIKey(GOOGLE_MAP_KEY)
        checkLogin()
        return true
    }
    func checkLogin() {
        guard let _ = Auth.auth().currentUser?.uid else {
            Navigator.setSignInRoot(window: window ?? UIWindow())
            return
        }
        Navigator.setHomeRoot(window: window ?? UIWindow())
    }
}

