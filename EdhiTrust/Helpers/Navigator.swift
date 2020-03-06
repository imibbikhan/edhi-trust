//
//  Router.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
import UIKit
enum Routes: String {
    case home = "StartHome"
    case missingsDonationsHome = "AllMissingsDonations"
    case signIn = "SignIn"
}
class Navigator {
    static func navigate(route to: Routes, from: UIViewController) {
        let id = to.rawValue
        let vc = STORYBOARD.instantiateViewController(withIdentifier: id)
        from.navigationController?.pushViewController(vc, animated: true)
    }
    static func setHomeRoot(window: UIWindow) {
        let vc = STORYBOARD.instantiateViewController(withIdentifier: Routes.home.rawValue)
        window.rootViewController = vc
    }
    static func setSignInRoot(window: UIWindow) {
        let vc = STORYBOARD.instantiateViewController(withIdentifier: Routes.signIn.rawValue)
        window.rootViewController = vc
    }
}
