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
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GMSServices.provideAPIKey("AIzaSyBzMuHUjLd1vJdtwbVO5-1ePPAO_ggsHfU")
//        GMSPlacesClient.provideAPIKey("")
        IQKeyboardManager.shared.enable = true
        checkLogin()
        return true
    }
    func checkLogin() {
        guard let _ = Auth.auth().currentUser?.uid else {
            Navigator.setRoot(window: window ?? UIWindow(), route: Routes.signIn)
            return
        }
        Navigator.setRoot(window: window ?? UIWindow(), route: Routes.home)
    }
}

