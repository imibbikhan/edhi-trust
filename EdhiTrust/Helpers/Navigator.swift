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
    case missingsDonationsHome = "Home"
    case signIn = "SignIn"
    case editProfile = "EditProfile"
    case viewBloodRequest = "ViewBloodRequest"
    case viewMissingRequest = "VewMissingRequest"
    case viewAllAmbulances = "AllAmbulances"
    case postBloodRequest = "PostBloodRequest"
    case postMissings = "PostMissings"
    case centerDetails = "CenterDetails"
    case donations = "Donations"
    case bloodRequests = "Blood"
    case missingsRequests = "Missings"
    case ambulance = "Ambulance"
    case callCenters = "CallCenters"
    case singleCenter = "SingleCenterView"
}
class Navigator {
    static func navigate(route to: Routes, from: UIViewController) {
        let id = to.rawValue
        let vc = STORYBOARD.instantiateViewController(withIdentifier: id)
        from.navigationController?.pushViewController(vc, animated: true)
    }
    static func setRoot(window: UIWindow, route: Routes) {
        let vc = STORYBOARD.instantiateViewController(withIdentifier: route.rawValue)
        window.rootViewController = vc
    }
    static func toViewBloodRequest(request: BloodRequestModel, from: UIViewController) {
        let vc = STORYBOARD.instantiateViewController(withIdentifier: Routes.viewBloodRequest.rawValue) as? ViewBloodRequestViewController
        vc?.bloodRequest = request
        from.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    static func toViewMissingRequest(missing: MissingModel, from: UIViewController) {
        let vc = STORYBOARD.instantiateViewController(withIdentifier: Routes.viewMissingRequest.rawValue) as? MissingViewViewController
        vc?.missing = missing
        from.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    static func toViewAmbulances(ambulances: [AmbulanceModel], from: UIViewController) {
        let vc = STORYBOARD.instantiateViewController(withIdentifier: Routes.viewAllAmbulances.rawValue) as? AllAmbulancesViewController
        vc?.ambulances = ambulances
        from.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    static func toEditBloodRequest(request: BloodRequestModel, from: UIViewController) {
        let vc = STORYBOARD.instantiateViewController(withIdentifier: Routes.postBloodRequest.rawValue) as? PostBloodRequestViewController
        vc?.bloodRequestModel = request
        from.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    static func toEditMissing(missing: MissingModel, from: UIViewController) {
        let vc = STORYBOARD.instantiateViewController(withIdentifier: Routes.postMissings.rawValue) as? PostMissingViewController
        vc?.missingModel = missing
        from.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    static func toSingleCenter(center: CallCenterModel, from: UIViewController) {
        let vc = STORYBOARD.instantiateViewController(withIdentifier: Routes.singleCenter.rawValue) as? SingleCenterViewController
        vc?.center = center
        from.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
}
