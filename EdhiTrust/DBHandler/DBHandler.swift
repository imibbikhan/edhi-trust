//
//  DBHandler.swift
//  EdhiTrust
//
//  Created by Ibbi Khan on 06/03/2020.
//  Copyright © 2020 Ibbi Khan. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase
class DBHandler {
    static var shared = DBHandler()
    
    func getAutoId()->String{
        return FB_DB_REF.childByAutoId().key ?? UUID().uuidString
    }
    func postBloodRequestDB(requestKey: String, data: Any, success: @escaping (String?)->Void) {
        FB_DB_REF.child("blood_requests/\(requestKey)").setValue(data) {
            (error, refer) in
            if let error = error {
                success(error.localizedDescription)
            }else{
                success(nil)
            }
        }
    }
    func getBloodRequestsDB(allRequests: Bool, fetched: @escaping ([BloodRequestModel], String?)->Void) {
        var query = FB_DB_REF.child("blood_requests").queryOrdered(byChild: "user_key").queryEqual(toValue: User.getUid())
        
        if !allRequests {
            query = FB_DB_REF.child("blood_requests")
        }
        var requests = [BloodRequestModel]()
        query.observe(.value, with: { (snapShot) in
//            print(snapShot)
            for case let request as DataSnapshot in snapShot.children {
                print(request)
                do {
                    
                    let decodedRequest = try FirebaseDecoder().decode(BloodRequestModel.self, from: request.value!)
                    print(decodedRequest)
                    requests.append(decodedRequest)
                }catch{
                    fetched(requests, error.localizedDescription)
                }
            }
            
            fetched(requests, nil)
            
        }) { (error) in
            fetched(requests, error.localizedDescription)
        }
        
    }
    
}
class User {
    static func getUid()->String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    static func getPhoneNumber()->String {
        return Auth.auth().currentUser?.phoneNumber ?? ""
    }
}
