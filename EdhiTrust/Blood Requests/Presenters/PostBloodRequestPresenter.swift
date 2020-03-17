//
//  PostBloodRequestPresenter.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
import CodableFirebase
class PostBloodRequestPresenter {
    var delegate: PostBloodRequestDelegate?
    
    func postBloodRequest(request: BloodRequestModel) {
        guard let delegate = self.delegate else { return }
        if !isValid(request: request) {
            delegate.error(message: "Make sure you enter all the inputs.")
            return
        }
        do {
            let path = "blood_requests/\(request.requestKey)"
            let data = try FirebaseEncoder().encode(request)
            DBHandler.shared.postNow(path: path, data: data) { (error) in
                guard let err = error else {
                    delegate.postSuccess()
                    return
                }
                delegate.error(message: err)

            }
        }catch{
            delegate.error(message: error.localizedDescription)
        }
    }
    fileprivate func isValid(request: BloodRequestModel) -> Bool {
        if request.age.count < 1 && request.bloodFor.count < 1 && request.fullAddress.count < 1 && request.referCity.count < 1 {
            return false
        }
        if request.requestType == "Select Request Type" {
            return false
        }
        if request.bloodGroup == "Select Blood Group" {
            return false
        }
        if request.gender == "Select Gender" {
            return false
        }
        
        return true
    }
}
